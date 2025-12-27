// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskModelImpl _$$TaskModelImplFromJson(Map<String, dynamic> json) =>
    _$TaskModelImpl(
      id: json['id'] as String,
      uid: json['uid'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      createdAt: _dateFromJson(json['createdAt'] as String),
      updatedAt: _dateFromJson(json['updatedAt'] as String),
      dueAt: _dateFromJson(json['dueAt'] as String),
      color: hexToColor(json['hexColor'] as String),
      isSynced: (json['isSynced'] as num).toInt(),
    );

Map<String, dynamic> _$$TaskModelImplToJson(_$TaskModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'title': instance.title,
      'description': instance.description,
      'createdAt': _dateToJson(instance.createdAt),
      'updatedAt': _dateToJson(instance.updatedAt),
      'dueAt': _dateToJson(instance.dueAt),
      'hexColor': colorToHex(instance.color),
      'isSynced': instance.isSynced,
    };
