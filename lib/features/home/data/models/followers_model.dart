
import 'package:mawhebtak/features/home/data/models/home_model.dart';

import '../../../feeds/data/models/posts_model.dart';

class FollowerAndFollowingModel {
  List<TopTalent>? data;
  Links? links;
  Meta? meta;
  String? msg;
  int? status;

  FollowerAndFollowingModel({
    this.data,
    this.links,
    this.meta,
    this.msg,
    this.status,
  });

  factory FollowerAndFollowingModel.fromJson(Map<String, dynamic> json) => FollowerAndFollowingModel(
    data: json["data"] == null ? [] : List<TopTalent>.from(json["data"]!.map((x) => TopTalent.fromJson(x))),
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

