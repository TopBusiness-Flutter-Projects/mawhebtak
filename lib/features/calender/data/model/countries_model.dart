class GetCountriesMainModel {
  List<GetCountriesMainModelData>? data;
  String? msg;
  int? status;

  GetCountriesMainModel({
    this.data,
    this.msg,
    this.status,
  });

  factory GetCountriesMainModel.fromJson(Map<String, dynamic> json) =>
      GetCountriesMainModel(
        data: json["data"] == null
            ? []
            : List<GetCountriesMainModelData>.from(json["data"]!
                .map((x) => GetCountriesMainModelData.fromJson(x))),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
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
