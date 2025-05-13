
import 'package:mawhebtak/core/models/pagenation_model.dart';
import 'package:mawhebtak/features/home/data/models/home_model.dart';

class RequestGigsModel {
  List<Top>? data;
  PaginationModel? links;
  String? msg;
  int? status;

  RequestGigsModel({
    this.data,
    this.links,
    this.msg,
    this.status,
  });

  factory RequestGigsModel.fromJson(Map<String, dynamic> json) => RequestGigsModel(
    data: json["data"] == null ? [] : List<Top>.from(json["data"]!.map((x) => Top.fromJson(x))),
    links: json["links"] == null ? null : PaginationModel.fromJson(json["links"]),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links?.toJson(),
    "msg": msg,
    "status": status,
  };
}
