
import 'package:mawhebtak/features/home/data/models/home_model.dart';

class TopTalentsModel {
  List<TopTalent>? data;
  String? msg;
  int? status;

  TopTalentsModel({
    this.data,
    this.msg,
    this.status,
  });

  factory TopTalentsModel.fromJson(Map<String, dynamic> json) => TopTalentsModel(
    data: json["data"] == null ? [] : List<TopTalent>.from(json["data"]!.map((x) => TopTalent.fromJson(x))),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
    "status": status,
  };
}

