import 'package:hive/hive.dart';

part 'work_model.g.dart';

@HiveType(typeId: 3)
class Work extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  List<Assistant>? assistants;



  Work({
    required this.id,
    required this.title,
    required this.assistants,
  });
}

@HiveType(typeId: 4)
class Assistant extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  List<String>? images; // List of image URLs or paths

  @HiveField(4)
  DateTime? date;

  @HiveField(5)
  DateTime? remindedTime;

  Assistant({
     this.id,
    required this.title,
    required this.description,
     this.images,
    required this.date,
    required this.remindedTime,
  });
}
