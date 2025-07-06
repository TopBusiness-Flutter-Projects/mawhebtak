class LoginModel {
  UserModel? data;
  String? msg;
  int? status;

  LoginModel({
    this.data,
    this.msg,
    this.status,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        data: json["data"] == null ? null : UserModel.fromJson(json["data"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "msg": msg,
        "status": status,
      };
}

class UserModel {
  int? id;
  String? name;
  int? notification;
  String? image;
  int? isRegister;
  String? email;
  String? phone;
  dynamic wallet;
  String? socialType;
  String? countryCode;
  String? token;
  String? referralCode;

  UserModel({
    this.id,
    this.name,
    this.notification,
    this.image,
    this.isRegister,
    this.countryCode,

    this.email,
    this.phone,
    this.wallet,
    this.socialType,
    this.token,
    this.referralCode,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        notification: json["notification"],
        image: json["image"],
        isRegister: json["is_register"],
    countryCode: json["country_code"],

    email: json["email"],
        phone: json["phone"],
        wallet: json["wallet"],
        socialType: json["social_type"],
        token: json["token"],
        referralCode: json["referral_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "notification": notification,
        "country_code":countryCode,
        "image": image,
        "is_register": isRegister,
        "email": email,
        "phone": phone,
        "wallet": wallet,
        "social_type": socialType,
        "token": token,
        "referral_code": referralCode,
      };

  UserModel copyWith({
    int? id,
    String? name,
    int? notification,
    String? image,
    int? isRegister,
    String? email,
    String? phone,
    dynamic wallet,
    String? socialType,
    String? token,
    String? referralCode,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      notification: notification ?? this.notification,
      image: image ?? this.image,
      isRegister: isRegister ?? this.isRegister,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      wallet: wallet ?? this.wallet,
      socialType: socialType ?? this.socialType,
      token: token ?? this.token,
      referralCode: referralCode ?? this.referralCode,
    );
  }
}
