// ignore_for_file: invalid_annotation_target

import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend/core/constants/utils.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String id,
    required String uid,
    required String title,
    required String description,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime dueAt,
    @JsonKey(name: 'hexColor', fromJson: hexToRgb, toJson: rgbToHex)
    required Color color,
    required int isSynced,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
