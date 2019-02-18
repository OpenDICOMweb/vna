// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// Author: Jim Philbin <jfphilbin@gmail.edu> -
// See the AUTHORS file for other contributors.
import 'package:core/server.dart' hide group;
import 'package:vna/vna.dart';
import 'package:test/test.dart';

// ignore_for_file: only_throw_errors
void main() {
  Server.initialize(name: 'entity_db/entity_db_test', level: Level.debug);

  group('Entity DB Tests', () {
    const dirPath = 'C:/odw/vna/test/vna_db_test';

    final ptUid0 = Uid();
    final pt0 = Patient('zero', ptUid0, null);
    final ptUid1 = Uid();
    final pt1 = Patient('one', ptUid1, null);

    final stUid0 = Uid();
    final st0 = Study(pt0, stUid0, null);
    final stUid1 = Uid();
    final st1 = Study(pt1, stUid1, null);

    final seUid0 = Uid();
    final se0 = Series(st0, seUid0, null);
    final seUid1 = Uid();
    final se1 = Series(st1, seUid1, null);

    final inUid0 = Uid();
    final in0 = Instance(se0, inUid0, null);
    final inUid1 = Uid();
    final in1 = Instance(se1, inUid1, null);

    test('VnaDB Test', () {
      global.throwOnError = false;

      final entityDB0 = EntityDB.empty(dirPath)
        ..add(pt0)
        ..add(pt1)
        ..add(st0)
        ..add(st1)
        ..add(se0)
        ..add(se1)
        ..add(in0)
        ..add(in1);

      EntityDB.write(entityDB0, dirPath);

      final entityDB1 = EntityDB.read(dirPath);

      final keys0 = entityDB0.patientStudiesMap.keys.toList();
      final keys1 = entityDB1.patientStudiesMap.keys.toList();

      print('k0: $keys0');
      print('k1: $keys1');

      if (keys0.length != keys1.length) throw 'bad key length';

      for (var i = 0; i < keys0.length; i++) {
        if (keys0[i] != keys1[i]) throw 'bad keys: \n\t$keys0 \n\t$keys1';
      }

      final values0 = entityDB0.patientStudiesMap.values.toList();
      final values1 = entityDB1.patientStudiesMap.values.toList();

      print('v0: $values0');
      print('v1: $values1');

      if (values0.length != values1.length) throw 'bad values length';
      if (keys0.length != values0.length) throw 'bad key/values length';

      for (var i = 0; i < values0.length; i++)
        if (values0[i][0] != values1[i][0])
          throw 'bad patient/study values: \n\t$values0 \n\t$values1';

      //
      final keys3 = entityDB0.entitiesMap.keys.toList();
      final keys4 = entityDB1.entitiesMap.keys.toList();

      if (keys3.length != keys4.length) throw 'bad key length';

      for (var i = 0; i < keys3.length; i++) {
        if (keys3[i] != keys4[i]) throw 'bad keys: \n\t$keys3 \n\t$keys4';
      }

      final values3 = entityDB0.entitiesMap.values.toList();
      final values4 = entityDB1.entitiesMap.values.toList();

      if (values3.length != values4.length) throw 'bad values length';
      if (keys3.length != values3.length) throw 'bad key/values length';

      for (var i = 0; i < values3.length; i++) {
        if (values3[i] != values4[i])
          throw 'bad entity/path values: \n\t$values3 \n\t$values4';
      }
    });
  });
}
