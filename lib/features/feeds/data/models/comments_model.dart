// To parse this JSON data, do
//
//     final commentsModel = commentsModelFromJson(jsonString);

import 'dart:convert';

CommentsModel commentsModelFromJson(String str) => CommentsModel.fromJson(json.decode(str));

String commentsModelToJson(CommentsModel data) => json.encode(data.toJson());

class CommentsModel {
  List<Datum>? data;
  String? msg;
  int? status;

  CommentsModel({
    this.data,
    this.msg,
    this.status,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
    "status": status,
  };
}

class Datum {
  int? id;
  String? comment;
  User? user;
  List<Reply>? reply;

  Datum({
    this.id,
    this.comment,
    this.user,
    this.reply,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
