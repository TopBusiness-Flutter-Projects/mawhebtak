
import 'package:mawhebtak/core/models/pagenation_model.dart';
import 'package:mawhebtak/features/feeds/data/models/posts_model.dart';


class RequestGigsModel {
  List<EventAndGigsModel>? data;
  PaginationModel? links;
  PaginationModel? meta;
  String? msg;
  int? status;

  RequestGigsModel({
    this.data,
    this.links,
    this.meta,
    this.msg,
    this.status,
  });

  factory RequestGigsModel.fromJson(Map<String, dynamic> json) => RequestGigsModel(
    data: json["data"] == null ? [] : List<EventAndGigsModel>.from(json["data"]!.map((x) => EventAndGigsModel.fromJson(x))),
    links: json["links"] == null ? null : PaginationModel.fromJson(json["links"]),
    meta: json["meta"] == null ? null : PaginationModel.fromJson(json["meta"]),
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

class EventAndGigsModel {
  int? id;
  String? image;
  String? title;
  List<Media>? media;
  String? description;
  String? location;
  String? price;

  EventAndGigsModel({
    this.id,
    this.image,
    this.media,
    this.title,
    this.location,
    this.description,
    this.price,
  });

  factory EventAndGigsModel.fromJson(Map<String, dynamic> json) => EventAndGigsModel(
    id: json["id"],
    image: json["image"],
    title: json["title"],
    media: json["media"] == null ? [] : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
    description: json["description"],
    location: json["location"],
    price: json["price"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "title": title,
    "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x.toJson())),
    "description": description,
    "price":price
  };
}