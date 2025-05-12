class ValidateDataMainModel {
  ValidateDataMainModelData? data;
  String? msg;
  int? status;

  ValidateDataMainModel({
    this.data,
    this.msg,
    this.status,
  });

  factory ValidateDataMainModel.fromJson(Map<String, dynamic> json) =>
      ValidateDataMainModel(
        data: json["data"] == null
            ? null
            : ValidateDataMainModelData.fromJson(json["data"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "msg": msg,
        "status": status,
      };
}

class ValidateDataMainModelData {
  String? email;
  int? otp;
  DateTime? otpExpired;

  ValidateDataMainModelData({
    this.email,
    this.otp,
    this.otpExpired,
  });

  factory ValidateDataMainModelData.fromJson(Map<String, dynamic> json) =>
      ValidateDataMainModelData(
        email: json["email"],
        otp: json["otp"],
        otpExpired: json["otp_expired"] == null
            ? null
            : DateTime.parse(json["otp_expired"]),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "otp": otp,
        "otp_expired": otpExpired?.toIso8601String(),
      };
}
