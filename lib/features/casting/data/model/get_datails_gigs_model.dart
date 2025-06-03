
import 'package:mawhebtak/features/casting/data/model/request_gigs_model.dart';

class GetDetailsGigsModel {
  EventAndGigsModel? data;
  String? msg;
  int? status;

  GetDetailsGigsModel({
    this.data,
    this.msg,
    this.status,
  });

  factory GetDetailsGigsModel.fromJson(Map<String, dynamic> json) => GetDetailsGigsModel(
    data: json["data"] == null ? null : EventAndGigsModel.fromJson(json["data"]),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "msg": msg,
    "status": status,
  };
}


