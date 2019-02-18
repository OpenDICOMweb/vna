//  Copyright (c) 2016, 2017, 2018
//  Poplar Hill Informatics and the American College of Radiology
//  All rights reserved.
//  Use of this source code is governed by the open source license
//  that can be found in the odw/LICENSE file.
//  Primary Author: Jim Philbin <jfphilbin@gmail.edu>
//  See the AUTHORS file for other contributors.
//
import 'dart:convert';
import 'dart:io';

import 'package:core/core.dart';

import 'package:json_annotation/json_annotation.dart';

part 'entity_db.g.dart';

// ignore_for_file: public_member_api_docs


/// A Database that maps [Uid]s to VNA paths.
@JsonSerializable(nullable: false)
class EntityDB {
  /// The default file where _this_ is stored.
  static const String entityPath = 'entity_db.json';

  /// A value which means that _this_ has not been created from a file
  /// containing the values for _this_.
  static final DateTime never = DateTime.tryParse('0000-01-01 00:00:00.000000');

  /// The path of the [Directory] where _this_ is stored.
  final String dirPath;

  /// A [Map<String, List<String>>] of [Patient.uid] [String] to a
  /// [List<String>] of the corresponding [Study.uid] [String]s.
  final Map<String, List<String>> patientStudiesMap;

  /// A [Map<String, String>] of [Entity.uid] [String] to the file path
  /// of the corresponding entity.
  final Map<String, String> entitiesMap;

  /// The [DateTime] when _this_ was last written to a stable store,
  /// e.g. a file.
  DateTime _lastWritten;

  /// Create an [EntityDB].
  EntityDB(this.dirPath, this.patientStudiesMap, this.entitiesMap,
      [DateTime lastWritten])
      : _lastWritten = lastWritten ??= never;

  factory EntityDB.fromJson(Map<String, dynamic> json) =>
      _$EntityDBFromJson(json);

  /// Creates an empty [EntityDB].
  EntityDB.empty(this.dirPath)
      : entitiesMap = <String, String>{},
        patientStudiesMap = <String, List<String>>{},
        _lastWritten = never;

  factory EntityDB.read(String dirPath) {
    final s = File('$dirPath/$entityPath').readAsStringSync();
    return _$EntityDBFromJson(jsonDecode(s));
  }

  String get path => '$dirPath/$entityPath';

  /// Add [e] to _this_.
  void add(Entity e) {
    if (e is Study) _addToPatientStudiesDB(e);
    _addToEntityUidPathDB(e);
  }

  bool _addToEntityUidPathDB(Entity e) {
    final s = e.toPath();
    final old = entitiesMap[e.uid];
    if (old != null) return invalidString('Path "$s" is already present');
    entitiesMap[e.uid.asString] = s;
    return true;
  }

  void _addToPatientStudiesDB(Study study) {
    final patientUid = study.patient.uid.asString;
    final studyUid = study.uid.asString;
    final old = patientStudiesMap[studyUid];
    (old != null)
        ? old.add(studyUid)
        : patientStudiesMap[patientUid] = [studyUid];
  }

  /// Returns the [Study]s associated with [patient].
  List<String> patientsStudies(Patient patient) =>
      patientStudiesMap[patient.uid.asString];

  @override
  String toString() => '''
$runtimeType:
  $dirPath
  $patientStudiesMap  
  $entitiesMap
  $_lastWritten
  ''';

  /// Write a [EntityDB] to [dirPath] as a JSON object
  /// corresponding to [Map<Uid, String>].
  static void write(EntityDB db, String dirPath) {
    db._lastWritten = DateTime.now();
    File(db.path).writeAsStringSync(jsonEncode(_$EntityDBToJson(db)));
  }
}
