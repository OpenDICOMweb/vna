// Copyright (c) 2016, Open DICOMweb Project. All rights reserved.
// Use of this source code is governed by the open source license
// that can be found in the LICENSE file.
// Author: Jim Philbin <jfphilbin@gmail.edu>
// See /[package]/AUTHORS file for other contributors.

import 'package:vna/src/utils.dart';

class Configuration {
  final String path;
  final Map<String, dynamic> config;

  factory Configuration.fromPath(String path) => load(path);

  Configuration._( this.path, this.config);

  String get configPath => config['configPath'];
  String get uidDBPath => config['uidDBPath'];

  static load([String path ='vna_config.json']) =>
      new Configuration._(path, loadMap(path));

  static final Map<String, dynamic> defaultConfigMap = <String, dynamic>{
    'configPath': 'vna_config.json',
    'uidDBPath': 'vna_uids.json'
  };
}