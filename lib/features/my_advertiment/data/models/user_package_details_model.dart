
class UserPackageDetailsModel {
  Data? data;
  String? msg;
  int? status;

  UserPackageDetailsModel({
    this.data,
    this.msg,
    this.status,
  });

  factory UserPackageDetailsModel.fromJson(Map<String, dynamic> json) => UserPackageDetailsModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "msg": msg,
    "status": status,
  };
}

class Data {
  Package? package;
  List<Ad>? ads;

  Data({
    this.package,
    this.ads,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    package: json["package"] == null ? null : Package.fromJson(json["package"]),
    ads: json["ads"] == null ? [] : List<Ad>.from(json["ads"]!.map((x) => Ad.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "package": package?.toJson(),
    "ads": ads == null ? [] : List<dynamic>.from(ads!.map((x) => x.toJson())),
  };
}

class Ad {
  String? status;
  DateTime? fromDate;
  DateTime? toDate;
  dynamic image;
  String? adConfirmation;

  Ad({
    this.status,
    this.fromDate,
    this.toDate,
    this.image,
    this.adConfirmation,
  });

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
    status: json["status"],
    fromDate: json["from_date"] == null ? null : DateTime.parse(json["from_date"]),
    toDate: json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
    image: json["image"],
    adConfirmation: json["ad_confirmation"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "from_date": "${fromDate!.year.toString().padLeft(4, '0')}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}",
    "to_date": "${toDate!.year.toString().padLeft(4, '0')}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}",
    "image": image,
    "ad_confirmation": adConfirmation,
  };
}

class Package {
  int? id;
  String? status;
  int? packageId;
  String? fromDate;
  String? toDate;
  int? numberOfAds;
  dynamic numberOfBumps;

  Package({
    this.id,
    this.status,
    this.packageId,
    this.fromDate,
    this.toDate,
    this.numberOfAds,
    this.numberOfBumps,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    id: json["id"],
    status: json["status"],
    packageId: json["package_id"],
    fromDate: json["start_date"] ,
    toDate: json["end_date"] ,
    numberOfAds: json["number_of_ads"],
    numberOfBumps: json["number_of_bumps"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "package_id": packageId,
    "start_date": fromDate,
    "end_date":toDate,
    "number_of_ads": numberOfAds,
    "number_of_bumps": numberOfBumps,
  };
}
