import 'posts_model.dart';

class GetDetailsOfPostModel {
  PostsModelData? data;
  String? msg;
  int? status;

  GetDetailsOfPostModel({
    this.data,
    this.msg,
    this.status,
  });

  factory GetDetailsOfPostModel.fromJson(Map<String, dynamic> json) =>
      GetDetailsOfPostModel(
        data:
            json["data"] == null ? null : PostsModelData.fromJson(json["data"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "msg": msg,
        "status": status,
      };
}
