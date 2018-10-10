//  Copyright (c) 2016, 2017, 2018,
//  Poplar Hill Informatics and the American College of Radiology
//  All rights reserved.
//  Use of this source code is governed by the open source license
//  that can be found in the odw/LICENSE file.
//  Primary Author: Jim Philbin <jfphilbin@gmail.edu>
//  See the AUTHORS file for other contributors.
//
import 'package:vna/src/utils.dart';

///
class VNAConfiguration {
  /// The path where _this_ can be found.
  final String path;

  /// A [Map] containing the configuration name/value pairs.
  final Map<String, dynamic> config;

  /// Create _this_ from the contents of the File at [path].
  factory VNAConfiguration.fromPath(String path) => VNAConfiguration.load(path);

  /// Load _this_ from [path];
  factory VNAConfiguration.load([String path = 'vna_config.json']) =>
      VNAConfiguration._(path, loadMap(path));

  VNAConfiguration._(this.path, this.config);

  /// The path to the VNA database.
  String get dbPath => config['dbPath'];

  /// The default configuration.
  static final Map<String, dynamic> defaultConfiguration = <String, dynamic>{
    'configPath': 'vna_config.json',
    'uidDBPath': 'vna_uids.json'
  };
}
