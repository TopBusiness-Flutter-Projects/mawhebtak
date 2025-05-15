
import 'package:mawhebtak/core/models/pagenation_model.dart';
import 'package:mawhebtak/features/home/data/models/request_gigs_model.dart';

class TopEventsModel {
  List<EventAndGigsModel>? data;
  PaginationModel? links;
  PaginationModel? meta;
  String? msg;
  int? status;

  TopEventsModel({
    this.data,
    this.links,
    this.meta,
    this.msg,
    this.status,
  });

  factory TopEventsModel.fromJson(Map<String, dynamic> json) => TopEventsModel(
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


