//  Copyright (c) 2016, 2017, 2018
//  Poplar Hill Informatics and the American College of Radiology
//  All rights reserved.
//  Use of this source code is governed by the open source license
//  that can be found in the odw/LICENSE file.
//  Primary Author: Jim Philbin <jfphilbin@gmail.edu>
//  See the AUTHORS file for other contributors.
//
import 'dart:collection';
import 'dart:io';

import 'package:core/core.dart';

/// A Database that maps [Uid]s to [Entity]s.
class EntityCache extends MapBase<Uid, Entity> {
  /// The default file where _this_ is stored.
  static const String defaultFile = 'entity_db.json';

  /// The [file] where this database is stored.
  final String file;

  /// The [Map<Uid, Entity>].
  final Map<Uid, Entity> dbMap;

  /// Creates an empty [EntityCache].
  EntityCache(this.file) : dbMap = <Uid, Entity>{};

  /// Creates a [EntityCache] from [dbMap].
  /// If written, the file will default to [file];
  EntityCache.from(this.dbMap, this.file);

/*
  /// Read and return an [EntityCache] from [dirPath].
  factory EntityCache.read(String dirPath) {
    final file = '$dirPath/$defaultFile';
    return EntityCache.from(readMap(file), file);
  }
*/

  // **** Map implementation ****

  /// Return the [Entity] with [Uid] if present; otherwise, _null_.
  @override
  Entity operator [](Object v) => dbMap[v];

  /// Sets the element with [Uid] to have a value of [Entity].
  @override
  void operator []=(Uid v, Entity e) => dbMap[v] = e;

  @override
  Iterable<Uid> get keys => dbMap.keys;

  @override
  void clear() {
    unsupportedError();
    return;
  }

  @override
  Entity remove(Object key) => unsupportedError();

  // **** End Map implementation ****

  /// Add [e] to _this_.
  bool add(Entity e) {
    final old = dbMap[e.uid];
    if (old != null) return invalidDuplicateEntityError(old, e);
    dbMap[e.uid] = e;
    return true;
  }

/* Urgent delete when working
  /// Write a [EntityCache] to [dir]/[file] as a JSON object
  /// corresponding to [Map<Uid, Entity>].
  static void write(EntityCache edb, String dir, [String file = defaultFile]) =>
      _writeCache(edb.dbMap, '$dir/$file');
*/

}

/// A database that maps [Patient] [Uid]s to a [List<Study>]
/// of the patient's [Study]s.
class PatientCache extends EntityCache {
  /// The default file where _this_ is stored.
  static const String defaultFile = 'patient_studies_db.json';

  /// Creates an empty [PatientCache].
  PatientCache([String file = defaultFile])
      : super.from(<Uid, Patient>{}, file);

  /// Creates a [PatientCache] from [dbMap]. If written, it will be written
  /// to [file], which defaults to [defaultFile];
  PatientCache.from(Map<Uid, Patient> dbMap, [String file = defaultFile])
      : super.from(dbMap, file);

/* Urgent delete when working
  /// Returns a [PatientCache] that is read from [file]. [file] must
  /// contain a JSON object corresponding to [Map<Uid, Patient>].
  factory PatientCache.read(String dirPath) {
    final file = '$dirPath/$defaultFile';
    return PatientCache.from(readMap(file), file);
  }

  /// Write a [PatientCache] to [dir]/[file] as a JSON object
  /// corresponding to [Map<Uid, Patient>].
  static void write(PatientCache db, String dir, [String file = defaultFile]) =>
      _writeCache(db.dbMap, '$dir/$file');
*/

}

/// A database that maps [Uid]s to [Study]s.
class StudyCache extends EntityCache {
  /// The default file where _this_ is stored.
  static const String defaultFile = 'patient_db.json';

  /// Creates an empty [StudyCache].
  StudyCache([String file = defaultFile]) : super.from(<Uid, Study>{}, file);

  /// Creates a [StudyCache] from [dbMap]. If written, it will be written
  /// to [file], which defaults to [defaultFile];
  StudyCache.from(Map<Uid, Study> db, [String file = defaultFile])
      : super.from(db, file);

/* Urgent delete when working
  /// Returns a [StudyCache] that is read from [file]. [file] must
  /// contain a JSON object corresponding to [Map<Uid, Study>].
  factory StudyCache.read(String dirPath) {
    final file = '$dirPath/$defaultFile';
    return StudyCache.from(readMap(file), file);
  }

  /// Write a [StudyCache] to [dir]/[file] as a JSON object
  /// corresponding to [Map<Uid, Study>].
  static void write(StudyCache db, String dir, [String file = defaultFile]) =>
      _writeCache(db.dbMap, '$dir/$file');
*/

}

/// A database that maps [Uid]s to [Series]s.
class SeriesCache extends EntityCache {
  /// The default file where _this_ is stored.
  static const String defaultFile = 'series_db.json';

  /// Creates an empty [SeriesCache].
  SeriesCache([String file = defaultFile]) : super.from(<Uid, Series>{}, file);

  /// Creates a [SeriesCache] from [map]. If written, it will be written
  /// to [file], which defaults to [defaultFile];
  SeriesCache.from(Map<Uid, Series> map, [String file = defaultFile])
      : super.from(map, file);

/* Urgent delete when working
  /// Returns a [SeriesCache] that is read from [file]. [file] must
  /// contain a JSON object corresponding to [Map<Uid, Series>].
  factory SeriesCache.read(String dirPath) {
    final file = '$dirPath/$defaultFile';
    return SeriesCache.from(readMap(file), file);
  }

  /// Write a [SeriesCache] to [dir]/[file] as a JSON object
  /// corresponding to [Map<Uid, Series>].
  static void write(SeriesCache db, String dir, [String file = defaultFile]) =>
      _writeCache(db.dbMap, '$dir/$file');
*/

}

/// A database that maps [Uid]s to [Instance]s.
class InstanceCache extends EntityCache {
  /// The default file where _this_ is stored.
  static const String defaultFile = 'study_db.json';

  /// Creates an empty [InstanceCache].
  InstanceCache([String file = defaultFile])
      : super.from(<Uid, Instance>{}, file);

  /// Creates a [InstanceCache] from [map]. If written, it will be written
  /// to [file], which defaults to [defaultFile];
  InstanceCache.from(Map<Uid, Instance> map, [String file = defaultFile])
      : super.from(map, file);

/* Urgent delete when working
  /// Returns a [InstanceCache] that is read from [file]. [file] must
  /// contain a JSON object corresponding to [Map<Uid, Instance>].
  factory InstanceCache.read(String dirPath) {
    final file = '$dirPath/$defaultFile';
    return InstanceCache.from(readMap(file), file);
  }

  /// Write a [InstanceCache] to [dir]/[file] as a JSON object corresponding to
  /// [Map<Uid, Instance>].
  static void write(InstanceCache db, String dir,
          [String file = defaultFile]) =>
      _writeCache(db.dbMap, '$dir/$file');
*/

}

/// A database containing the [Uid]s of all [Entity]s known to a VNA.
class VnaUidCache {
  /// The default file where _this_ is stored.
  static const String defaultDir = 'vna_uid_db';

  /// The path to the root directory of _this_.
  final String rootDirPath;

  /// All [Entity] [Uid]s and the corresponding Entities known to this VNA.
  final EntityCache entities;

  /// All [Patient] [Uid]s and the corresponding [Patient]s known to this VNA.
  final PatientCache patients;

  /// All [Study] [Uid]s and the corresponding [Study]s known to this VNA.
  final StudyCache studies;

  /// All [Series] [Uid]s and the corresponding [Series]s known to this VNA.
  final SeriesCache series;

  /// All [Instance] [Uid]s and the corresponding [Instance]s known to this VNA.
  final InstanceCache instances;

  /// Constructor
  VnaUidCache(this.rootDirPath, this.entities, this.patients, this.studies,
      this.series, this.instances);

  /// Creates an empty VnaUidCache.
  VnaUidCache.empty(this.rootDirPath)
      : entities = EntityCache(rootDirPath),
        patients = PatientCache(rootDirPath),
        studies = StudyCache(rootDirPath),
        series = SeriesCache(rootDirPath),
        instances = InstanceCache(rootDirPath);

  /// Add an Entry to _this_.
  bool add(Patient patient, Study study, Series series, Instance instance) {
    studies.add(patient);
    entities.add(patient);

    studies.add(study);
    entities.add(study);

    studies.add(series);
    entities.add(series);

    studies.add(instance);
    entities.add(instance);

    return true;
  }

  /// Add the VNA UID Cache entries for SOP Instance [RootDataset].
  //Urgent add failure branch
  bool addRootDataset(RootDataset rds) {
    final patient = Patient.fromRootDataset(rds);
    final study = Study.fromRootDataset(rds, patient);
    final series = Series.fromRootDataset(rds, study);
    final instance = Instance.fromRootDataset(rds, series);

    add(patient, study, series, instance);
    return true;
  }

/* Urgent delete when working
  /// Write a [VnaUidCache] to [Directory] [dir] as a JSON object
  /// corresponding to [Map<Uid, Instance>]. If [dir] is not
  /// supplied it defaults to [defaultDir].
  void write([String dir = defaultDir]) {
    EntityCache.write(entities, dir);
    PatientCache.write(patients, dir);
    StudyCache.write(studies, dir);
    SeriesCache.write(series, dir);
    InstanceCache.write(instances, dir);
  }
*/

}

/* Urgent delete when working
/// Writes a [Map<Uid, Entity] to [path] as a JSON object
/// corresponding to [Map<Uid, Entity>].
void _writeCache(Map<Uid, Entity> map, String path) {
  final s = entityMapToString(map);
  print('s: $s');
  File(path).writeAsStringSync(s);
}
*/

/*
/// Returns a [Map] that is read from [path]. [path] must
/// contain a JSON object corresponding to [Map<Uid, Entity>].
Map<Uid, K> readMap<K>(String path) {
  final s = File(path).readAsStringSync();
  print('read s: $s');
  final Object v = cvt.json.decode(s);
  print('map: ${v.runtimeType} $v');
  return v;
}
*/

/// Writes a [Map<Uid, Entity] to [path] as a JSON object
/// corresponding to [Map<Uid, Entity>].
void writeMap(Map<Uid, Entity> map, String path) {
  final s = entityMapToString(map);
  print('s: $s');
  File(path).writeAsStringSync(s);
}

/// Encodes a [Map<Uid,Entity>] to a JSON [String].
String entityMapToString(Map<Uid, Entity> map) {
  final sb = StringBuffer('{');
  final entries = map.entries;
  final len = entries.length;
  var i = 0;
  for (final entry in entries) {
    final uid = entry.key;
    final path = entry.value.toPath();
    sb.write('"$uid": "$path"');
    print('$i $path');
    i++;
    if (i < len) sb.write(',');
  }
  sb.write('}');
  return '$sb';
}
