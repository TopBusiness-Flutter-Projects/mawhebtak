
class AddPostModel {
  Data? data;
  String? msg;
  int? status;

  AddPostModel({
    this.data,
    this.msg,
    this.status,
  });

  factory AddPostModel.fromJson(Map<String, dynamic> json) => AddPostModel(
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
  User? user;
  String? body;
  int? commentCount;
  int? reactionCount;

  Data({
    this.id,
    this.user,
    this.body,
    this.commentCount,
    this.reactionCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    body: json["body"],
    commentCount: json["comment_count"],
    reactionCount: json["reaction_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user?.toJson(),
    "body": body,
    "comment_count": commentCount,
    "reaction_count": reactionCount,
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
