class PackagesModel {
  List<PackagesModelData>? data;
  String? msg;
  int? status;

  PackagesModel({
    this.data,
    this.msg,
    this.status,
  });

  factory PackagesModel.fromJson(Map<String, dynamic> json) => PackagesModel(
        data: json["data"] == null
            ? []
            : List<PackagesModelData>.from(
                json["data"]!.map((x) => PackagesModelData.fromJson(x))),
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

class PackagesModelData {
  int? id;
  String? title;
  int? numberOfDays;
  int? numberOfAds;
  dynamic price;
  int? discount;
  dynamic priceAfterDiscount;

  PackagesModelData({
    this.id,
    this.title,
    this.numberOfDays,
    this.numberOfAds,
    this.price,
    this.discount,
    this.priceAfterDiscount,
  });

  factory PackagesModelData.fromJson(Map<String, dynamic> json) =>
      PackagesModelData(
        id: json["id"],
        title: json["title"],
        numberOfDays: json["number_of_days"],
        numberOfAds: json["number_of_ads"],
        price: json["price"],
        discount: json["discount"],
        priceAfterDiscount: json["price_after_discount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "number_of_days": numberOfDays,
        "number_of_ads": numberOfAds,
        "price": price,
        "discount": discount,
        "price_after_discount": priceAfterDiscount,
      };
}
