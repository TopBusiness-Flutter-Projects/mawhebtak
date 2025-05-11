import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';

part 'work_model.g.dart';

@HiveType(typeId: 0)
class WorkModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  List<Assistant>? assistants;

  WorkModel({
    required this.id,
    required this.title,
    required this.assistants,
  });
}

@HiveType(typeId: 1)
class Assistant extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? image;

  @HiveField(4)
  DateTime? date;

  @HiveField(5)
  DateTime? remindedTime;

  @HiveField(6)
  bool? isActive;

  Assistant({
    this.id,
    this.title,
    this.description,
    this.image,
    this.date,
    this.remindedTime,
    this.isActive,
  });
}
