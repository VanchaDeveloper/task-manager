// ignore_for_file: invalid_annotation_target

import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend/core/constants/utils.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
abstract class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String id,
    required String uid,
    required String title,
    required String description,
    @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
    required DateTime createdAt,
    @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
    required DateTime updatedAt,
    @JsonKey(fromJson: _dateFromJson, toJson: _dateToJson)
    required DateTime dueAt,
    @JsonKey(name: 'hexColor', fromJson: hexToColor, toJson: colorToHex)
    required Color color,
    required int isSynced,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}

/// ---- JSON helpers ----

DateTime _dateFromJson(String value) => DateTime.parse(value);
String _dateToJson(DateTime date) => date.toIso8601String();

Color hexToColor(String hex) => hexToRgb(hex);
String colorToHex(Color color) => rgbToHex(color);
