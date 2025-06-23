

import 'package:mawhebtak/features/feeds/data/models/posts_model.dart';
import 'package:mawhebtak/features/jobs/data/model/user_jop_details_model.dart';

class UserJobModel {
    List<JopData>? data;
    Links? links;
    Meta? meta;
    String? msg;
    int? status;

    UserJobModel({
        this.data,
        this.links,
        this.meta,
        this.msg,
        this.status,
    });

    factory UserJobModel.fromJson(Map<String, dynamic> json) => UserJobModel(
        data: json["data"] == null ? [] : List<JopData>.from(json["data"]!.map((x) => JopData.fromJson(x))),
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




