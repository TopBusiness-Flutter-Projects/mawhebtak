
import 'package:mawhebtak/features/auth/new_account/data/model/user_types.dart';
import 'package:mawhebtak/features/casting/data/model/request_gigs_model.dart';
import 'package:mawhebtak/features/feeds/data/models/posts_model.dart';

class ProfileModel {
  Data? data;
  String? msg;
  int? status;
  ProfileModel({
    this.data,
    this.msg,
    this.status,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
  String? name;
  String? headline;
  String? avatar;
  String? bgCover;
  MainRegisterUserTypesData? userType;
  MainRegisterUserTypesData? userSubType;
  String? followersCount;
  String? followingCount;
  String? postsCount;
  String? location;
  String? phone;
  String? bio;
  String? email;
  int? age;
  int? syndicate;
  List<Experience>? experiences;
  List<PostsModelData>? timeline;
  List<EventAndGigsModel>? myGigs;

  Data({
    this.id,
    this.name,
    this.headline,
    this.avatar,
    this.bgCover,
    this.userType,
    this.userSubType,
    this.phone,
    this.followersCount,
    this.followingCount,
    this.postsCount,
    this.location,
    this.bio,
    this.email,
    this.age,
    this.syndicate,
    this.experiences,
    this.timeline,
    this.myGigs,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    headline: json["headline"],
    avatar: json["avatar"],
    phone: json["phone"],
    bgCover: json["bg_cover"],
    userType: json["user_type"] == null ? null : MainRegisterUserTypesData.fromJson(json["user_type"]),
    userSubType: json["user_sub_type"] == null ? null : MainRegisterUserTypesData.fromJson(json["user_sub_type"]),
    followersCount: json["followers_count"],
    followingCount: json["following_count"],
    postsCount: json["posts_count"],
    location: json["location"],
    bio: json["bio"],
    email: json["email"],
    age: json["age"],
    syndicate: json["syndicate"],
    experiences: json["experiences"] == null ? [] : List<Experience>.from(json["experiences"]!.map((x) => Experience.fromJson(x))),
    timeline: json["timeline"] == null ? [] : List<PostsModelData>.from(json["timeline"]!.map((x) => PostsModelData.fromJson(x))),
    myGigs: json["my_gigs"] == null ? [] : List<EventAndGigsModel>.from(json["my_gigs"]!.map((x) => EventAndGigsModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "headline": headline,
    "avatar": avatar,
    "bg_cover": bgCover,
    "user_type": userType?.toJson(),
    "user_sub_type": userSubType?.toJson(),
    "followers_count": followersCount,
    "following_count": followingCount,
    "posts_count": postsCount,
    "location": location,
    "bio": bio,
    "email": email,
    "age": age,
    "syndicate": syndicate,
    "experiences": experiences == null ? [] : List<dynamic>.from(experiences!.map((x) => x.toJson())),
    "timeline": timeline == null ? [] : List<dynamic>.from(timeline!.map((x) => x.toJson())),
    "my_gigs": myGigs == null ? [] : List<dynamic>.from(myGigs!.map((x) => x.toJson())),
  };
}

class Experience {
  String? title;
  String? description;
  String? from;
  DateTime? to;

  Experience({
    this.title,
    this.description,
    this.from,
    this.to,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
    title: json["title"],
    description: json["description"],
    from: json["from"],
    to: json["to"] == null ? null : DateTime.parse(json["to"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "from": from,
    "to": "${to!.year.toString().padLeft(4, '0')}-${to!.month.toString().padLeft(2, '0')}-${to!.day.toString().padLeft(2, '0')}",
  };
}





