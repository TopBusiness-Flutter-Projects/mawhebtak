
import 'package:mawhebtak/core/models/pagenation_model.dart';
import 'package:mawhebtak/features/home/data/models/home_model.dart';

class AnnouncementsModel {
  List<Announcement>? data;
  PaginationModel? links;
  PaginationModel? meta;
  String? msg;
  int? status;

  AnnouncementsModel({
    this.data,
    this.links,
    this.meta,
    this.msg,
    this.status,
  });

  factory AnnouncementsModel.fromJson(Map<String, dynamic> json) => AnnouncementsModel(
    data: json["data"] == null ? [] : List<Announcement>.from(json["data"]!.map((x) => Announcement.fromJson(x))),
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



