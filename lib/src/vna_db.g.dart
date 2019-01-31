// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vna_db.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntityDB _$EntityDBFromJson(Map<String, dynamic> json) {
  return EntityDB(
      json['dirPath'] as String,
      (json['patientStudiesMap'] as Map<String, dynamic>).map(
          (k, e) => MapEntry(k, (e as List).map((e) => e as String).toList())),
      Map<String, String>.from(json['entitiesMap'] as Map),
      DateTime.parse(json['lastWritten'] as String));
}

Map<String, dynamic> _$EntityDBToJson(EntityDB instance) => <String, dynamic>{
      'dirPath': instance.dirPath,
      'patientStudiesMap': instance.patientStudiesMap,
      'entitiesMap': instance.entitiesMap,
      'lastWritten': instance._lastWritten.toIso8601String()
    };
