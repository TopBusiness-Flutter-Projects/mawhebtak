
import 'package:mawhebtak/features/jobs/data/model/user_jop_details_model.dart';

class UserJobFavouriteModel {
  List<JopData>? data;
  String? msg;
  int? status;

  UserJobFavouriteModel({
    this.data,
    this.msg,
    this.status,
  });

  factory UserJobFavouriteModel.fromJson(Map<String, dynamic> json) => UserJobFavouriteModel(
    data: json["data"] == null ? [] : List<JopData>.from(json["data"]!.map((x) => JopData.fromJson(x))),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
    "status": status,
  };
}


