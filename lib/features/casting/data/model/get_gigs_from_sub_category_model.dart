
import 'package:mawhebtak/features/home/data/models/request_gigs_model.dart';

class GetGigsFromSubCategoryModel {
  List<EventAndGigsModel>? data;
  String? msg;
  int? status;

  GetGigsFromSubCategoryModel({
    this.data,
    this.msg,
    this.status,
  });

  factory GetGigsFromSubCategoryModel.fromJson(Map<String, dynamic> json) => GetGigsFromSubCategoryModel(
    data: json["data"] == null ? [] : List<EventAndGigsModel>.from(json["data"]!.map((x) => EventAndGigsModel.fromJson(x))),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
    "status": status,
  };
}

