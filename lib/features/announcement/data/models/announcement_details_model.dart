
import '../../../home/data/models/home_model.dart';

class AnnouncementDetailsModel {
  Announcement? data;
  String? msg;
  int? status;

  AnnouncementDetailsModel({
    this.data,
    this.msg,
    this.status,
  });

  factory AnnouncementDetailsModel.fromJson(Map<String, dynamic> json) => AnnouncementDetailsModel(
    data: json["data"] == null ? null : Announcement.fromJson(json["data"]),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "msg": msg,
    "status": status,
  };
}


