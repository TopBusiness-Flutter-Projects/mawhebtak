
class AddAdOfferPackageToLawyerModel {
  Data? data;
  String? msg;
  int? status;

  AddAdOfferPackageToLawyerModel({
    this.data,
    this.msg,
    this.status,
  });

  factory AddAdOfferPackageToLawyerModel.fromJson(Map<String, dynamic> json) => AddAdOfferPackageToLawyerModel(
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
  int? id;
  String? status;
  String? packageId;
  DateTime? startDate;
  DateTime? endDate;
  int? numberOfBumps;
  String? isExpired;

  Data({
    this.id,
    this.status,
    this.packageId,
    this.startDate,
    this.endDate,
    this.numberOfBumps,
    this.isExpired,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    status: json["status"],
    packageId: json["package_id"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    numberOfBumps: json["number_of_bumps"],
    isExpired: json["is_expired"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "package_id": packageId,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "number_of_bumps": numberOfBumps,
    "is_expired": isExpired,
  };
}
