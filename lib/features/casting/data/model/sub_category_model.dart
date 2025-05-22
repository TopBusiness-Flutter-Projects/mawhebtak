
class SubCategoryModel {
  List<SubCategoryModelData>? data;
  String? msg;
  int? status;

  SubCategoryModel({
    this.data,
    this.msg,
    this.status,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
    data: json["data"] == null ? [] : List<SubCategoryModelData>.from(json["data"]!.map((x) => SubCategoryModelData.fromJson(x))),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
    "status": status,
  };
}

class SubCategoryModelData {
  int? id;
  String? name;

  SubCategoryModelData({
    this.id,
    this.name,
  });

  factory SubCategoryModelData.fromJson(Map<String, dynamic> json) => SubCategoryModelData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
