import 'package:mawhebtak/core/models/pagenation_model.dart';

class GetCountriesMainModel {
  List<GetCountriesMainModelData>? data;
  PaginationModel? links;
  PaginationModel? meta;
  String? msg;
  int? status;

  GetCountriesMainModel({
    this.data,
    this.links,
    this.meta,
    this.msg,
    this.status,
  });

  factory GetCountriesMainModel.fromJson(Map<String, dynamic> json) =>
      GetCountriesMainModel(
        data: json["data"] == null
            ? []
            : List<GetCountriesMainModelData>.from(json["data"]!
                .map((x) => GetCountriesMainModelData.fromJson(x))),
        links: json["links"] == null ? null : PaginationModel.fromJson(json["links"]),
        meta: json["meta"] == null ? null : PaginationModel.fromJson(json["meta"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links?.toJson(),
    "meta": meta?.toJson(),
    "msg": msg,
        "status": status,
      };
}

class GetCountriesMainModelData {
  int? id;
  String? name;
  String? currency;

  GetCountriesMainModelData({
    this.id,
    this.name,
    this.currency,
  });

  factory GetCountriesMainModelData.fromJson(Map<String, dynamic> json) =>
      GetCountriesMainModelData(
        id: json["id"],
        name: json["name"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "currency": currency,
  };


}

