
class CategoryModel {
  List<CategoryModelData>? data;
  String? msg;
  int? status;

  CategoryModel({
    this.data,
    this.msg,
    this.status,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    data: json["data"] == null ? [] : List<CategoryModelData>.from(json["data"]!.map((x) => CategoryModelData.fromJson(x))),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
    "status": status,
  };
}

class CategoryModelData {
  int? id;
  String? name;

  CategoryModelData({
    this.id,
    this.name,
  });

  factory CategoryModelData.fromJson(Map<String, dynamic> json) => CategoryModelData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
