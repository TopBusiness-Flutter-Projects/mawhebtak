
class AddNewGigModel {
  List<AddNewGigModelData>? data;
  String? msg;
  int? status;

  AddNewGigModel({
    this.data,
    this.msg,
    this.status,
  });

  factory AddNewGigModel.fromJson(Map<String, dynamic> json) => AddNewGigModel(
    data: json["data"] == null ? [] : List<AddNewGigModelData>.from(json["data"]!.map((x) => AddNewGigModelData.fromJson(x))),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
    "status": status,
  };
}

class AddNewGigModelData {
  int? id;
  String? comment;
  User? user;
  List<Reply>? reply;

  AddNewGigModelData({
    this.id,
    this.comment,
    this.user,
    this.reply,
  });

  factory AddNewGigModelData.fromJson(Map<String, dynamic> json) => AddNewGigModelData(
    id: json["id"],
    comment: json["comment"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    reply: json["reply"] == null ? [] : List<Reply>.from(json["reply"]!.map((x) => Reply.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "comment": comment,
    "user": user?.toJson(),
    "reply": reply == null ? [] : List<dynamic>.from(reply!.map((x) => x.toJson())),
  };
}

class Reply {
  User? user;
  dynamic postReplyId;
  String? reply;

  Reply({
    this.user,
    this.postReplyId,
    this.reply,
  });

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    postReplyId: json["post_reply_id"],
    reply: json["reply"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "post_reply_id": postReplyId,
    "reply": reply,
  };
}

class User {
  int? id;
  String? name;
  String? image;
  dynamic headline;
  int? followersCount;

  User({
    this.id,
    this.name,
    this.image,
    this.headline,
    this.followersCount,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    headline: json["headline"],
    followersCount: json["followers_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "headline": headline,
    "followers_count": followersCount,
  };
}
