
import 'package:mawhebtak/features/home/data/models/home_model.dart';

class AnnouncementFavouriteModel {
  List<Announcement>? data;
  String? msg;
  int? status;

  AnnouncementFavouriteModel({
    this.data,
    this.msg,
    this.status,
  });

  factory AnnouncementFavouriteModel.fromJson(Map<String, dynamic> json) => AnnouncementFavouriteModel(
    data: json["data"] == null ? [] : List<Announcement>.from(json["data"]!.map((x) => Announcement.fromJson(x))),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
    "status": status,
  };
}

