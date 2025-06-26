
class GetLawyerAdPackagesModel {
  List<GetLawyerAdPackagesModelData>? data;
  String? msg;
  int? status;

  GetLawyerAdPackagesModel({
    this.data,
    this.msg,
    this.status,
  });

  factory GetLawyerAdPackagesModel.fromJson(Map<String, dynamic> json) => GetLawyerAdPackagesModel(
    data: json["data"] == null ? [] : List<GetLawyerAdPackagesModelData>.from(json["data"]!.map((x) => GetLawyerAdPackagesModelData.fromJson(x))),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
    "status": status,
  };
}

class GetLawyerAdPackagesModelData {
  int? id;
  String? status;
  int? packageId;
  String? startDate;
  String? endDate;
  int? numberOfAds;
  int? numberOfBumps;
  String? isExpired;

  GetLawyerAdPackagesModelData({
    this.id,
    this.status,
    this.packageId,
    this.startDate,
    this.endDate,
    this.numberOfAds,
    this.numberOfBumps,
    this.isExpired,
  });

  factory GetLawyerAdPackagesModelData.fromJson(Map<String, dynamic> json) => GetLawyerAdPackagesModelData(
    id: json["id"],
    status: json["status"],
    packageId: json["package_id"],
    startDate: json["start_date"] ,
    endDate: json["end_date"],
    numberOfAds: json["number_of_ads"],
    numberOfBumps: json["number_of_bumps"],
    isExpired: json["is_expired"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "package_id": packageId,
    "start_date": startDate,
    "end_date": endDate,
    "number_of_ads": numberOfAds,
    "number_of_bumps": numberOfBumps,
    "is_expired": isExpired,
  };
}
