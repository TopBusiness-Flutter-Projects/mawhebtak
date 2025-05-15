
import 'package:mawhebtak/core/models/pagenation_model.dart';


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
  String? description;
  String? from;

  EventAndGigsModel({
    this.id,
    this.image,
    this.title,
    this.description,
    this.from,
  });

  factory EventAndGigsModel.fromJson(Map<String, dynamic> json) => EventAndGigsModel(
    id: json["id"],
    image: json["image"],
    title: json["title"],
    description: json["description"],
    from: json["from"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "title": title,
    "description": description,
    "from": from,
  };
}