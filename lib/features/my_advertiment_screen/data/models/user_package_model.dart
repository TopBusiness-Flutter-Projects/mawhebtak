
class UserPackageModel {
  List<UserPackageModelData>? data;
  String? msg;
  int? status;

  UserPackageModel({
    this.data,
    this.msg,
    this.status,
  });

  factory UserPackageModel.fromJson(Map<String, dynamic> json) => UserPackageModel(
    data: json["data"] == null ? [] : List<UserPackageModelData>.from(json["data"]!.map((x) => UserPackageModelData.fromJson(x))),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
    "status": status,
  };
}

class UserPackageModelData {
  int? id;
  int? packageId;
  int? userId;
  String? packageTitle;
  DateTime? startDate;
  DateTime? endDate;
  int? numberOfBumps;
  int? isExpired;

  UserPackageModelData({
    this.id,
    this.packageId,
    this.userId,
    this.packageTitle,
    this.startDate,
    this.endDate,
    this.numberOfBumps,
    this.isExpired,
  });

  factory UserPackageModelData.fromJson(Map<String, dynamic> json) => UserPackageModelData(
    id: json["id"],
    packageId: json["package_id"],
    userId: json["user_id"],
    packageTitle: json["package_title"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    numberOfBumps: json["number_of_bumps"],
    isExpired: json["is_expired"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "package_id": packageId,
    "user_id": userId,
    "package_title": packageTitle,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "number_of_bumps": numberOfBumps,
    "is_expired": isExpired,
  };
}
