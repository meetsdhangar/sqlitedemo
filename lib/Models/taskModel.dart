// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TaskModel {
  int id;
  String title;
  String createdAt;
  String? updatedAt;
  TaskModel({
    required this.id,
    required this.title,
    required this.createdAt,
    this.updatedAt,
  });

  factory TaskModel.fromSqliteDatabase(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as int,
      title: map['title'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'])
          .toIso8601String(),
      updatedAt: map['updated_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updated_at'])
              .toIso8601String()
          : null,
    );
  }
}
