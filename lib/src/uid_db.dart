// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// Author: Jim Philbin <jfphilbin@gmail.edu>
// See the AUTHORS file for other contributors.

import 'dart:convert';
import 'dart:io';

import 'package:core/core.dart';
import 'package:vna/src/utils.dart';

class VNADB {
  final String name;
  final String path;
  final Map<Uid, Uid> idToDeId;
  final Map<Uid, Uid> deIdToId;
  final Map<Uuid, Study> idPatient;
  final Map<Uid, Study> uidToStudy;
  final Map<Uid, Series> uidToSeries;
  final Map<Uid, Instance> uidToInstance;

  VNADB(this.name,
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

  VNADB._(this.name, this.path, this.idToDeId, this.deIdToId, this.idPatient,
      this.uidToStudy, this.uidToSeries, this.uidToInstance);

  static const defaultPath = 'vna_uids.json';

  void hunload([String path = 'vna_uids.json']) {
    final dbMap = <String, dynamic>{};
    dbMap['idToDeId'] = idToDeId;
    dbMap['deIdToId'] = deIdToId;
    dbMap['idPatient'] = idPatient;
    dbMap['uidToStudy'] = uidToStudy;
    dbMap['uidToSeries'] = uidToSeries;
    dbMap['uidToInstance'] = uidToInstance;
    new File(path).writeAsStringSync(JSON.encode(dbMap));
  }

  static load(String id, [String path = defaultPath]) {
    final uids = loadMap(path);
    return new VNADB._(
        id,
        path,
        uids["idToDeId"],
        uids["deIdToId"],
        uids["idPatient"],
        uids["uidToStudy"],
        uids["uidToSeries"],
        uids["uidToInstance"]);
  }

  static MapEntry<Uid, Uid> _uidMapEntry(String key, String value) =>
      new MapEntry(new Uid(key), new Uid(value));

  static Map<Uid, Uid> stringMapToUidMap(Map<String, String> stringMap) =>
      stringMap.map(_uidMapEntry);

  static MapEntry<String, String> _stringMapEntry(Uid key, Uid value) =>
      new MapEntry(key.asString, value.asString);

  static Map<String, String> uidMapToStringMap(Map<Uid, Uid> uidMap) =>
      uidMap.map(_stringMapEntry);
}
