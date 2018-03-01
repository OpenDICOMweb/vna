// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// Author: Jim Philbin <jfphilbin@gmail.edu>
// See the AUTHORS file for other contributors.

import 'dart:convert';
import 'dart:io';

// TODO: move these to IO
Map loadMap(String path) {
  final source = new File(path).readAsStringSync();
  return JSON.decode(source);
}

void unloadMap(String path, Map map) {
  final s = JSON.encode(map);
  new File(path).writeAsStringSync(s);
}

