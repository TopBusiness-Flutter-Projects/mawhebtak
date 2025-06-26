// To parse this JSON data, do
//
//     final getAdOfferPackagesModel = getAdOfferPackagesModelFromJson(jsonString);

import 'dart:convert';

GetAdOfferPackagesModel getAdOfferPackagesModelFromJson(String str) =>
    GetAdOfferPackagesModel.fromJson(json.decode(str));

String getAdOfferPackagesModelToJson(GetAdOfferPackagesModel data) =>
    json.encode(data.toJson());

class GetAdOfferPackagesModel {
  List<GetAdOfferPackagesModelData>? data;

  GetAdOfferPackagesModel({
    this.data,
  });

  factory GetAdOfferPackagesModel.fromJson(Map<String, dynamic> json) =>
      GetAdOfferPackagesModel(
        data: json["data"] == null
            ? []
            : List<GetAdOfferPackagesModelData>.from(json["data"]!
                .map((x) => GetAdOfferPackagesModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetAdOfferPackagesModelData {
  int? id;
  String? title;
  int? numberOfDays;
  int? numberOfAds;
  double? price;
  int? discount;
  String? status;

  GetAdOfferPackagesModelData({
    this.id,
    this.title,
    this.numberOfDays,
    this.numberOfAds,
    this.price,
    this.discount,
    this.status,
  });

  factory GetAdOfferPackagesModelData.fromJson(Map<String, dynamic> json) =>
      GetAdOfferPackagesModelData(
        id: json["id"],
        title: json["title"],
        numberOfDays: json["number_of_days"],
        numberOfAds: json["number_of_ads"],
        price: json["price"]?.toDouble(),
        discount: json["discount"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "number_of_days": numberOfDays,
        "number_of_ads": numberOfAds,
        "price": price,
        "discount": discount,
        "status": status,
      };
}
