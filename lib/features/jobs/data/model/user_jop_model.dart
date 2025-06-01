
import 'package:mawhebtak/features/feeds/data/models/posts_model.dart';

class UserJopModel {
  List<UserJopData>? data;
  Links? links;
  Meta? meta;
  String? msg;
  int? status;

  UserJopModel({
    this.data,
    this.links,
    this.meta,
    this.msg,
    this.status,
  });

  factory UserJopModel.fromJson(Map<String, dynamic> json) => UserJopModel(
    data: json["data"] == null ? [] : List<UserJopData>.from(json["data"]!.map((x) => UserJopData.fromJson(x))),
    links: json["links"] == null ? null : Links.fromJson(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links?.toJson(),
    "meta": meta?.toJson(),
    "msg": msg,
    "status": status,
  };
}

class UserJopData {
  int? id;
  String? title;
  String? description;
  String? location;
  String? deadline;
  bool? isMine;
  bool? isFav;

  UserJopData({
    this.id,
    this.title,
    this.description,
    this.location,
    this.deadline,
    this.isMine,
    this.isFav,
  });

  factory UserJopData.fromJson(Map<String, dynamic> json) => UserJopData(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    location: json["location"],
    deadline: json["deadline"],
    isMine: json["is_mine"],
    isFav: json["is_fav"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "location": location,
    "deadline": deadline,
    "is_mine": isMine,
    "is_fav": isFav,
  };
}


