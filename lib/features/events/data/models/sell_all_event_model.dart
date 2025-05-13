
import 'package:mawhebtak/features/home/data/models/home_model.dart';

class SeeAllEventModel {
  List<Top>? data;
  String? msg;
  int? status;

  SeeAllEventModel({
    this.data,
    this.msg,
    this.status,
  });

  factory SeeAllEventModel.fromJson(Map<String, dynamic> json) => SeeAllEventModel(
    data: json["data"] == null ? [] : List<Top>.from(json["data"]!.map((x) => Top.fromJson(x))),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
    "status": status,
  };
}


