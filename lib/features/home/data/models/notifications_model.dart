
class GetNotificationsModel {
  GetNotificationsModelData? data;
  String? msg;
  int? status;

  GetNotificationsModel({
    this.data,
    this.msg,
    this.status,
  });

  factory GetNotificationsModel.fromJson(Map<String, dynamic> json) => GetNotificationsModel(
    data: json["data"] == null ? null : GetNotificationsModelData.fromJson(json["data"]),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "msg": msg,
    "status": status,
  };
}

class GetNotificationsModelData {
  int? id;
  String? name;
  int? notification;
  String? image;
  int? isRegister;
  String? email;
  String? phone;
  double? wallet;
  String? socialType;
  String? token;

  GetNotificationsModelData({
    this.id,
    this.name,
    this.notification,
    this.image,
    this.isRegister,
    this.email,
    this.phone,
    this.wallet,
    this.socialType,
    this.token,
  });

  factory GetNotificationsModelData.fromJson(Map<String, dynamic> json) => GetNotificationsModelData(
    id: json["id"],
    name: json["name"],
    notification: json["notification"],
    image: json["image"],
    isRegister: json["is_register"],
    email: json["email"],
    phone: json["phone"],
    wallet: json["wallet"]?.toDouble(),
    socialType: json["social_type"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "notification": notification,
    "image": image,
    "is_register": isRegister,
    "email": email,
    "phone": phone,
    "wallet": wallet,
    "social_type": socialType,
    "token": token,
  };
}
