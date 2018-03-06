// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// Author: Jim Philbin <jfphilbin@gmail.edu>
// See /[package]/AUTHORS file for other contributors.

import 'package:vna/src/config.dart';
import 'package:vna/src/uid_db.dart';

/// A singleton class that contains global values
class VNA {
  final Configuration config;
  final VNADB uidDB;

  VNA(this.config, this.uidDB);

  static void initialize() {
    Configuration.load();
    VNADB.load(_config.uidDBPath);


  }
}

final Configuration _config = Configuration.load();
