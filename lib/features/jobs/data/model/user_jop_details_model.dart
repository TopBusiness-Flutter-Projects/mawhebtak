import '../../../events/data/model/event_details_model.dart';

class UserJobDetailsModel {
  Data? data;
  String? msg;
  int? status;

  UserJobDetailsModel({
    this.data,
    this.msg,
    this.status,
  });

  factory UserJobDetailsModel.fromJson(Map<String, dynamic> json) =>
      UserJobDetailsModel(
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
  String? title;
  String? description;
  String? location;
  String? deadline;
  List<Media>? media;
  String? priceStartAt;
  String? priceEndAt;
  Poster? poster;
  bool? isMine;
  bool? isFav;

  Data({
    this.id,
    this.title,
    this.description,
    this.location,
    this.deadline,
    this.media,
    this.priceStartAt,
    this.priceEndAt,
    this.poster,
    this.isMine,
    this.isFav,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        location: json["location"],
        deadline: json["deadline"],
        media: json["media"] == null
            ? []
            : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
        priceStartAt: json["price_start_at"],
        priceEndAt: json["price_end_at"],
        poster: json["poster"] == null ? null : Poster.fromJson(json["poster"]),
        isMine: json["is_mine"],
        isFav: json["is_fav"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "location": location,
        "deadline": deadline,
        "media": media == null
            ? []
            : List<dynamic>.from(media!.map((x) => x.toJson())),
        "price_start_at": priceStartAt,
        "price_end_at": priceEndAt,
        "poster": poster?.toJson(),
        "is_mine": isMine,
        "is_fav": isFav,
      };
}

class Poster {
  int? id;
  String? name;
  String? image;
  dynamic headline;
  int? followersCount;
  bool? isIFollow;

  Poster({
    this.id,
    this.name,
    this.image,
    this.headline,
    this.followersCount,
    this.isIFollow,
  });

  factory Poster.fromJson(Map<String, dynamic> json) => Poster(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        headline: json["headline"],
        followersCount: json["followers_count"],
        isIFollow: json["is_i_follow"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "headline": headline,
        "followers_count": followersCount,
        "is_i_follow": isIFollow,
      };
}
