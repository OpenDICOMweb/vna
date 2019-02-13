// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// Original author: Jim Philbin <jfphilbin@gmail.edu> -
// See the AUTHORS file for other contributors.
//
import 'dart:convert';
import 'dart:io';

import 'package:core/core.dart';
import 'package:vna/src/utils.dart';

/// The database for a Vendor Neutral Archive
class VnaDB {
  /// The name of _this_.
  final String name;

  /// The _path_ to _this_.
  final String path;

  /// A [Map] from [Uuid]s/[Uid]s to [Entity]s. All [Entity]s known
  /// to the VNA are stored in [entities].
  final Map<Object, Entity> entities;

  /// A [Map] from [Patient] ID to [Patient] [Uuid].
  final Map<String, Uuid> patientIDs;

  /// A [Map] from [Patient] [Uuid] to [Patient].
  final Map<Uuid, Patient> patients;

  /// A [Map] from [Study] [Uid] to [Study].
  final Map<Uid, Study> studies;

  /// A [Map] from [Series] [Uid] to [Series].
  final Map<Uid, Series> series;

  /// A [Map] from [Instance] [Uid] to [Instance].
  final Map<Uid, Instance> instances;

  /// A [Map] from an _identified_ [Patient] [Uuid] to a _de-identified_
  /// [Patient] [Uuid].
  final Map<Uuid, Uuid> deIdentified;

  /// A [Map] from a _de-identified_ [Patient] [Uuid] to an _identified_
  /// [Patient] [Uuid].
  final Map<Uuid, Uuid> identified;

  /// Creates a new VNA Database.
  VnaDB(this.name, {
    this.path = defaultPath,
    Map<Object, Entity> entities,
    Map<String, Uuid> patientIDs,
    Map<Uuid, Patient> patients,
    Map<Uid, Study> studies,
    Map<Uid, Series> series,
    Map<Uid, Instance> instances,
    Map<Uid, Uid> deIdentified,
    Map<Uid, Uid> identified,
  })
      : entities = entities ?? {},
        patientIDs = patientIDs ?? {},
        patients = patients ?? <Uuid, Patient>{},
        studies = studies ?? <Uid, Study>{},
        series = series ?? <Uid, Series>{},
        instances = instances ?? <Uid, Instance>{},
        deIdentified = deIdentified ?? <Uuid, Uuid>{},
        identified = identified ?? <Uuid, Uuid>{};

  /// Load a VNA database from a path.
  factory VnaDB.load(String id, [String path = defaultPath]) {
    final uids = loadMap(path);
    return VnaDB._(
      id,
      path,
      uids['entities'],
      uids['patients'],
      uids['patientIDs'],
      uids['studies'],
      uids['series'],
      uids['instances'],
      uids['deIdentified'],
      uids['identified'],
    );
  }

  /// Private Constructor
  VnaDB._(this.name,
      this.path,
      this.entities,
      this.patientIDs,
      this.patients,
      this.studies,
      this.series,
      this.instances,
      this.deIdentified,
      this.identified);

  /// Adds the [Entity]s contained in a [RootDataset] to the [VnaDB].
  //TODO: this will be expanded to handle Mint study and series objects.
  Instance addSopInstance(RootDataset rds) {
    final pid = rds.getString(kPatientID);
    if (pid == null) return elementNotPresentError(PTag.kPatientID);
    var uuid = patientIDs[pid];

    Patient patient;
    if (uuid == null) {
      // Unknown PID
      uuid = Uuid();
      patient = Patient.fromRootDataset(rds);
      if (patient == null) {
        log.warn('Dataset: $rds without patient');
      } else {
        _tryAddEntity(uuid, patient);
        patientIDs[pid] = uuid;
        patients[uuid] = patient;
      }
    } else {
      patient = patients[uuid];
      if (patient == null) {
        log.error('Known PID("$pid") but Patient not present');
        return null;
      }
    }

    final studyUid = rds.getUid(kStudyInstanceUID);
    var study = studies[studyUid];
    if (study == null) {
      study = Study.fromRootDataset(rds, patient);
      _tryAddEntity(studyUid, study);
      patient.addIfAbsent(study);
      studies[studyUid] = study;
    }

    final seriesUid = rds.getUid(kSeriesInstanceUID);
    var s = series[seriesUid];
    if (s == null) {
      s = Series.fromRootDataset(rds, study);
      _tryAddEntity(seriesUid, s);
      study.addIfAbsent(s);
      series[seriesUid] = s;
    }

    final instanceUid = rds.getUid(kSOPInstanceUID);
    var instance = instances[instanceUid];
    if (instance == null) {
      instance = Instance.fromRootDataset(rds, s);
      _tryAddEntity(instanceUid, instance);
      s.addIfAbsent(instance);
      instances[instanceUid] = instance;
    } else {
      return duplicateEntityError(instance, Instance.fromRootDataset(rds, s));
    }
    return instance;
  }

  /// Try to add an Entity to [entities].
  void _tryAddEntity(Object uuidOruid, Entity entity) {
    final e = entities[uuidOruid];
    if (e != null)
      return (e != entity) ? duplicateEntityError(e, entity) : null;
    entities[uuidOruid] = entity;
  }

  /// Stores the VNA database at [path].
  void store([String path = 'vna_db.json']) {
    final dbMap = <String, dynamic>{};
    dbMap['patientIDs'] = patientIDs;
    dbMap['patients'] = patients;
    dbMap['studies'] = studies;
    dbMap['series'] = series;
    dbMap['uidToInstance'] = instances;
    dbMap['deIdentified'] = deIdentified;
    dbMap['identified'] = identified;
    File(path).writeAsStringSync(json.encode(dbMap));
  }

  /// The default path for _this_.
  static const String defaultPath = 'vna_db.json';
}
