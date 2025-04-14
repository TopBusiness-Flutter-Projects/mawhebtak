// To parse this JSON data, do
//
//     final getHomeFilter = getHomeFilterFromJson(jsonString);

import 'dart:convert';

GetHomeFilter getHomeFilterFromJson(String str) => GetHomeFilter.fromJson(json.decode(str));

String getHomeFilterToJson(GetHomeFilter data) => json.encode(data.toJson());

class GetHomeFilter {
  String? msg;
  List<Datum>? data;
  int? status;

  GetHomeFilter({
    this.msg,
    this.data,
    this.status,
  });

  factory GetHomeFilter.fromJson(Map<String, dynamic> json) => GetHomeFilter(
    msg: json["msg"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "status": status,
  };
}

class Datum {
  int? id;
  String? name;
  int? moduleId;
  String? image;
  String? latitude;
  String? longitude;
  int? rate;
  int? users;
  bool? isFav;

  Datum({
    this.id,
    this.name,
    this.moduleId,
    this.image,
    this.latitude,
    this.longitude,
    this.rate,
    this.users,
    this.isFav,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    moduleId: json["module_id"],
    image: json["image"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    rate: json["rate"],
    users: json["users"],
    isFav: json["is_fav"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "module_id": moduleId,
    "image": image,
    "latitude": latitude,
    "longitude": longitude,
    "rate": rate,
    "users": users,
    "is_fav": isFav,
  };
}
