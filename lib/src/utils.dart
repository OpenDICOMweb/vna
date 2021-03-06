//  Copyright (c) 2016, 2017, 2018,
//  Poplar Hill Informatics and the American College of Radiology
//  All rights reserved.
//  Use of this source code is governed by the open source license
//  that can be found in the odw/LICENSE file.
//  Primary Author: Jim Philbin <jfphilbin@gmail.edu>
//  See the AUTHORS file for other contributors.
//

import 'dart:convert';
import 'dart:io';

// TODO: move these to IO
/// Loads a [Map<String, Object> from [path];
Map loadMap(String path) {
  final source =  File(path).readAsStringSync();
  return jsonDecode(source);
}

/// Stores a [Map<String, Object> at [path];
void unloadMap(String path, Map map) {
  final s = jsonEncode(map);
  File(path).writeAsStringSync(s);
}

