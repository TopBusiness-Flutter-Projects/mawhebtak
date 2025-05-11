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

  LoginModel copyWith({
    UserModel? data,
    String? msg,
    int? status,
  }) {
    return LoginModel(
      data: data ?? this.data,
      msg: msg ?? this.msg,
      status: status ?? this.status,
    );
  }
}

class UserModel {
  int? id;
  String? name;
  int? notification;
  String? image;
  String? email;
  String? phone;
  int? wallet;
  dynamic socialType;
  String? token;

  UserModel.User({
    this.id,
    this.name,
    this.notification,
    this.image,
    this.email,
    this.phone,
    this.wallet,
    this.socialType,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel.User(
        id: json["id"],
        name: json["name"],
        notification: json["notification"],
        image: json["image"],
        email: json["email"],
        phone: json["phone"],
        wallet: json["wallet"],
        socialType: json["social_type"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "notification": notification,
        "image": image,
        "email": email,
        "phone": phone,
        "wallet": wallet,
        "social_type": socialType,
        "token": token,
      };

  UserModel copyWith({
    int? id,
    String? name,
    int? notification,
    String? image,
    String? email,
    String? phone,
    int? wallet,
    dynamic socialType,
    String? token,
  }) {
    return UserModel.User(
      id: id ?? this.id,
      name: name ?? this.name,
      notification: notification ?? this.notification,
      image: image ?? this.image,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      wallet: wallet ?? this.wallet,
      socialType: socialType ?? this.socialType,
      token: token ?? this.token,
    );
  }
}
