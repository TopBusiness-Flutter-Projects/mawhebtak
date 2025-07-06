import '../../../calender/data/model/countries_model.dart';
import '../../../casting/data/model/request_gigs_model.dart';
import '../../../feeds/data/models/posts_model.dart';

class ProfileModel {
  MyProfileModelData? data;
  String? msg;
  int? status;

  ProfileModel({
    this.data,
    this.msg,
    this.status,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        data: json["data"] == null
            ? null
            : MyProfileModelData.fromJson(json["data"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "msg": msg,
        "status": status,
      };
}

class MyProfileModelData {
  int? id;
  String? name;
  String? headline;
  String? avatar;
  String? phone;
  String? bgCover;
  GetCountriesMainModelData? userType;
  List<GetCountriesMainModelData>? userSubTypes;
  dynamic followersCount;
  dynamic followingCount;
  dynamic postsCount;
  String? location;
  String? countryCode;
  String? bio;
  String? email;
  dynamic age;
  dynamic syndicate;
  List<Experience>? experiences;
  List<PostsModelData>? timeline;
  List<EventAndGigsModel>? myGigs;
  List<Review>? reviews;
  bool? isIFollow;
  bool? isIReviewed;
  int? isPhoneHidden;

  MyProfileModelData({
    this.id,
    this.name,
    this.headline,
    this.avatar,
    this.phone,
    this.bgCover,
    this.userType,
    this.userSubTypes,
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
    this.reviews,
    this.isIFollow,
    this.isIReviewed,
    this.isPhoneHidden,
    this.countryCode,
  });

  factory MyProfileModelData.fromJson(Map<String, dynamic> json) =>
      MyProfileModelData(
        id: json["id"],
        name: json["name"],
        headline: json["headline"],
        countryCode: json["country_code"],
        avatar: json["avatar"],
        phone: json["phone"],
        bgCover: json["bg_cover"],
        experiences:
            json["experiences"] == null || (json["experiences"] as List).isEmpty
                ? null
                : List<Experience>.from(
                    json["experiences"].map((x) => Experience.fromJson(x))),
        timeline: json["timeline"] == null || (json["timeline"] as List).isEmpty
            ? null
            : List<PostsModelData>.from(
                json["timeline"].map((x) => PostsModelData.fromJson(x))),
        myGigs: json["my_gigs"] == null || (json["my_gigs"] as List).isEmpty
            ? null
            : List<EventAndGigsModel>.from(
                json["my_gigs"].map((x) => EventAndGigsModel.fromJson(x))),
        reviews: json["reviews"] == null || (json["reviews"] as List).isEmpty
            ? null
            : List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        userType: json["user_type"] == null
            ? null
            : GetCountriesMainModelData.fromJson(json["user_type"]),
        userSubTypes: json["user_sub_types"] == null ? [] : List<GetCountriesMainModelData>.from(json["user_sub_types"]!.map((x) => GetCountriesMainModelData.fromJson(x))),

        followersCount: json["followers_count"],
        followingCount: json["following_count"],
        postsCount: json["posts_count"],
        location: json["location"],
        bio: json["bio"],
        email: json["email"],
        age: json["age"],
        syndicate: json["syndicate"],
        isIFollow: json["is_i_follow"],
        isIReviewed: json["is_i_reviewed"],
        isPhoneHidden: json["is_phone_hidden"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_code": countryCode,
        "headline": headline,
        "avatar": avatar,
        "phone": phone,
        "bg_cover": bgCover,
        "user_type": userType?.toJson(),
    "user_sub_types": userSubTypes == null ? [] : List<dynamic>.from(userSubTypes!.map((x) => x.toJson())),
    "followers_count": followersCount,
        "following_count": followingCount,
        "posts_count": postsCount,
        "location": location,
        "bio": bio,
        "email": email,
        "age": age,
        "syndicate": syndicate,
        "is_i_follow": isIFollow,
        "is_i_reviewed": isIReviewed,
        "is_phone_hidden": isPhoneHidden,
        "experiences": experiences == null
            ? []
            : List<dynamic>.from(experiences!.map((x) => x.toJson())),
        "timeline": timeline == null
            ? []
            : List<dynamic>.from(timeline!.map((x) => x.toJson())),
        "my_gigs":
            myGigs == null ? [] : List<dynamic>.from(myGigs!.map((x) => x)),
        "reviews":
            reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
      };
}

class Experience {
  String? title;
  int? id;
  String? description;
  DateTime? from;
  DateTime? to;

  Experience({
    this.id,
    this.title,
    this.description,
    this.from,
    this.to,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        title: json["title"],
        id: json["id"],
        description: json["description"],
        from: json["from"] == null ? null : DateTime.parse(json["from"]),
        to: json["to"] == null ? null : DateTime.parse(json["to"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "from":
            "${from!.year.toString().padLeft(4, '0')}-${from!.month.toString().padLeft(2, '0')}-${from!.day.toString().padLeft(2, '0')}",
        "to":
            "${to!.year.toString().padLeft(4, '0')}-${to!.month.toString().padLeft(2, '0')}-${to!.day.toString().padLeft(2, '0')}",
      };
}

class User {
  int? id;
  String? name;
  String? image;
  dynamic headline;
  int? followersCount;
  bool? isIFollow;
  int? isDeleteOrdered;

  User({
    this.id,
    this.name,
    this.image,
    this.headline,
    this.followersCount,
    this.isIFollow,
    this.isDeleteOrdered,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        headline: json["headline"],
        followersCount: json["followers_count"],
        isIFollow: json["is_i_follow"],
        isDeleteOrdered: json["is_delete_ordered"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "headline": headline,
        "followers_count": followersCount,
        "is_i_follow": isIFollow,
        "is_delete_ordered": isDeleteOrdered,
      };
}

class UserType {
  int? id;
  String? name;

  UserType({
    this.id,
    this.name,
  });

  factory UserType.fromJson(Map<String, dynamic> json) => UserType(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Review {
  int? id;
  User? user;
  dynamic? review;
  String? comment;

  Review({
    this.id,
    this.user,
    this.review,
    this.comment,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        review: json["review"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "review": review,
        "comment": comment,
      };
}
