
import 'package:mawhebtak/features/feeds/data/models/posts_model.dart';

class NotificationModel {
  List<GetNotificationsModelData>? data;
  String? msg;
  Links? links;
  Meta? meta;
  int? status;

  NotificationModel({
    this.data,
    this.links,
    this.meta,
    this.msg,
    this.status,

  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    data: json["data"] == null ? [] : List<GetNotificationsModelData>.from(json["data"]!.map((x) => GetNotificationsModelData.fromJson(x))),
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

class GetNotificationsModelData {
  int? id;
  String? title;
  String? body;
  int? seen;
  int? referenceId;
  String? referenceTable;
  String? createdAt;

  GetNotificationsModelData({
    this.id,
    this.title,
    this.body,
    this.seen,
    this.referenceId,
    this.referenceTable,
    this.createdAt,
  });

  factory GetNotificationsModelData.fromJson(Map<String, dynamic> json) => GetNotificationsModelData(
    id: json["id"],
    title: json["title"],
    body: json["body"],
    seen: json["seen"],
    referenceId: json["reference_id"],
    referenceTable:json["reference_table"],
    createdAt: json["created_at"] ,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "body": body,
    "seen": seen,
    "reference_id": referenceId,
    "reference_table": referenceTable,
    "created_at": createdAt,
  };
}


