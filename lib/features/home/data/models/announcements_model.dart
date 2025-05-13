
import 'package:mawhebtak/features/home/data/models/home_model.dart';

class AnnouncementsModel {
  List<Announcement>? data;
  String? msg;
  int? status;

  AnnouncementsModel({
    this.data,
    this.msg,
    this.status,
  });

  factory AnnouncementsModel.fromJson(Map<String, dynamic> json) => AnnouncementsModel(
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



class User {
  int? id;
  String? name;
  String? image;
  dynamic headline;
  int? followersCount;

  User({
    this.id,
    this.name,
    this.image,
    this.headline,
    this.followersCount,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    headline: json["headline"],
    followersCount: json["followers_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "headline": headline,
    "followers_count": followersCount,
  };
}
