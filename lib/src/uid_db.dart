// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// Author: Jim Philbin <jfphilbin@gmail.edu>
// See the AUTHORS file for other contributors.
import 'dart:convert';
import 'dart:io';

import 'package:core/core.dart';
import 'package:vna/src/utils.dart';

// ignore_for_file: public_member_api_docs
// ignore_for_file: prefer_constructors_over_static_methods

class UidDB {
  final String name;
  final String path;
  final Map<Uid, Uid> idToDeId;
  final Map<Uid, Uid> deIdToId;
  final Map<Uuid, Study> idPatient;
  final Map<Uid, Study> uidToStudy;
  final Map<Uid, Series> uidToSeries;
  final Map<Uid, Instance> uidToInstance;

  UidDB(this.name,
      {Map<Uid, Uid> idToDeId,
      Map<Uid, Uid> deIdToId,
      Map<Uid, Uid> idPatient,
      Map<Uid, Uid> uidToStudy,
      Map<Uid, Uid> uidToSeries,
      Map<Uid, Uid> uidToInstance})
      : path = defaultPath,
        idToDeId = idToDeId ?? <Uid, Uid>{},
        deIdToId = deIdToId ?? <Uid, Uid>{},
        idPatient = idPatient ?? <Uuid, Patient>{},
        uidToStudy = uidToStudy ?? <Uid, Study>{},
        uidToSeries = uidToSeries ?? <Uid, Series>{},
        uidToInstance = uidToInstance ?? <Uid, Instance>{};

  UidDB._(this.name, this.path, this.idToDeId, this.deIdToId, this.idPatient,
      this.uidToStudy, this.uidToSeries, this.uidToInstance);

  static const String defaultPath = 'vna_uids.json';

  void hunload([String path = 'vna_uids.json']) {
    final dbMap = <String, dynamic>{};
    dbMap['idToDeId'] = idToDeId;
    dbMap['deIdToId'] = deIdToId;
    dbMap['idPatient'] = idPatient;
    dbMap['uidToStudy'] = uidToStudy;
    dbMap['uidToSeries'] = uidToSeries;
    dbMap['uidToInstance'] = uidToInstance;
    File(path).writeAsStringSync(jsonEncode(dbMap));
  }

  static UidDB load(String id, [String path = defaultPath]) {
    final uids = loadMap(path);
    return UidDB._(
        id,
        path,
        uids['idToDeId'],
        uids['deIdToId'],
        uids['idPatient'],
        uids['uidToStudy'],
        uids['uidToSeries'],
        uids['uidToInstance']);
  }

  static MapEntry<Uid, Uid> _uidMapEntry(String key, String value) =>
       MapEntry( Uid(key),  Uid(value));

  static Map<Uid, Uid> stringMapToUidMap(Map<String, String> stringMap) =>
      stringMap.map(_uidMapEntry);

  static MapEntry<String, String> _stringMapEntry(Uid key, Uid value) =>
       MapEntry(key.asString, value.asString);

  static Map<String, String> uidMapToStringMap(Map<Uid, Uid> uidMap) =>
      uidMap.map(_stringMapEntry);
}
