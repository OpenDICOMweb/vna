//  Copyright (c) 2016, 2017, 2018,
//  Poplar Hill Informatics and the American College of Radiology
//  All rights reserved.
//  Use of this source code is governed by the open source license
//  that can be found in the odw/LICENSE file.
//  Primary Author: Jim Philbin <jfphilbin@gmail.edu>
//  See the AUTHORS file for other contributors.
//
import 'package:vna/src/config.dart';
import 'package:vna/src/vna_db.dart';

/// A singleton class that contains global values
class VNA {
  /// The Database associated with _this_.
  final VnaDB db;
  /// The configuration of _this_.
  final VNAConfiguration config;


  /// A DICOM Vendor Neutral Archive
  VNA(String name, this.config, [VnaDB db]) : db = db ??= VnaDB(name);

  /// Load an existing [VNA].
  static void load() {
    VNAConfiguration.load();
    VnaDB.load(_config.dbPath);


  }
}

final VNAConfiguration _config = VNAConfiguration.load();
