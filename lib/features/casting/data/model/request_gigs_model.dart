import 'package:mawhebtak/core/models/pagenation_model.dart';
import 'package:mawhebtak/features/feeds/data/models/posts_model.dart';

import '../../../home/data/models/home_model.dart';

class RequestGigsModel {
  List<EventAndGigsModel>? data;
  PaginationModel? links;
  PaginationModel? meta;
  String? msg;
  int? status;

  RequestGigsModel({
    this.data,
    this.links,
    this.meta,
    this.msg,
    this.status,
  });

  factory RequestGigsModel.fromJson(Map<String, dynamic> json) =>
      RequestGigsModel(
        data: json["data"] == null
            ? []
            : List<EventAndGigsModel>.from(
                json["data"]!.map((x) => EventAndGigsModel.fromJson(x))),
        links: json["links"] == null
            ? null
            : PaginationModel.fromJson(json["links"]),
        meta: json["meta"] == null
            ? null
            : PaginationModel.fromJson(json["meta"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "links": links?.toJson(),
        "meta": meta?.toJson(),
        "msg": msg,
        "status": status,
      };
}

class EventAndGigsModel {
  int? id;
  String? image;
  String? title;
  List<Media>? media;
  String? description;
  String? location;
  String? price;
  String? discount;
  String? priceAfterDiscount;
  String? from;
  String? isRequested;
  bool? isMine;
  List<GigsRequestList>? gigsRequests;
  TopTalent? user;

  EventAndGigsModel({
    this.id,
    this.image,
    this.media,
    this.title,
    this.location,
    this.description,
    this.user,
    this.price,
    this.discount,
    this.priceAfterDiscount,
    this.from,
    this.isRequested,
    this.isMine,
    this.gigsRequests,
  });

  factory EventAndGigsModel.fromJson(Map<String, dynamic> json) =>
      EventAndGigsModel(
        id: json["id"],
        image: json["image"],
        title: json["title"],
        user: json["user"] == null ? null : TopTalent.fromJson(json["user"]),
        media: json["media"] == null
            ? []
            : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
        description: json["description"],
        location: json["location"],
        price: json["price"],
        discount: json["discount"],
        priceAfterDiscount: json["price_after_discount"],
        from: json["from"],
        isRequested: json["is_requested"],
        isMine: json["is_mine"],
        gigsRequests: json["gigs_requests"] == null
            ? []
            : List<GigsRequestList>.from(
                json["gigs_requests"]!.map((x) => GigsRequestList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "title": title,
        "media": media == null
            ? []
            : List<dynamic>.from(media!.map((x) => x.toJson())),
        "description": description,
        "price": price,
        "discount": discount,
        "price_after_discount": priceAfterDiscount,
        "user": user?.toJson(),
        "from": from
      };
}

class GigsRequestList {
  int? id;
  User? user;
  String? status;
  DateTime? createdAt;

  GigsRequestList({
    this.id,
    this.user,
    this.status,
    this.createdAt,
  });

  factory GigsRequestList.fromJson(Map<String, dynamic> json) =>
      GigsRequestList(
        id: json["id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "status": status,
        "created_at": createdAt?.toIso8601String(),
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
