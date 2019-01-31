//  Copyright (c) 2016, 2017, 2018
//  Poplar Hill Informatics and the American College of Radiology
//  All rights reserved.
//  Use of this source code is governed by the open source license
//  that can be found in the odw/LICENSE file.
//  Primary Author: Jim Philbin <jfphilbin@gmail.edu>
//  See the AUTHORS file for other contributors.
//
import 'package:vna/vna.dart';

const String dirPath = 'C:/odw/vna';

const Map<String, List<String>> patientStudies = <String, List<String>>{
'foo': ['a', 'b', 'c'],
'bar': ['d', 'e', 'f']
};

const Map<String, String> entities = <String,String>{
  'x': 'path0',
  'y': 'path1'
};

const Map<String, dynamic>testDB = <String, dynamic>{
  'dirPath': dirPath,
  'patientStudiesMap': patientStudies,
  'entitiesMap': entities
};

void main(List<String> arguments) {

  final db0 = EntityDB(dirPath, patientStudies, entities);

  print('$db0');

  EntityDB.write(db0, dirPath);
  final db1 = EntityDB.read(dirPath);

  print('$db1');


}
