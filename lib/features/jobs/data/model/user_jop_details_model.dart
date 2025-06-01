
class UserJopDetailsModel {
  UserJopDetailsData? data;
  String? msg;
  int? status;

  UserJopDetailsModel({
    this.data,
    this.msg,
    this.status,
  });

  factory UserJopDetailsModel.fromJson(Map<String, dynamic> json) => UserJopDetailsModel(
    data: json["data"] == null ? null : UserJopDetailsData.fromJson(json["data"]),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "msg": msg,
    "status": status,
  };
}

class UserJopDetailsData {
  int? id;
  String? title;
  String? description;
  String? location;
  String? deadline;
  String? priceStartAt;
  String? priceEndAt;
  Poster? poster;
  bool? isMine;

  UserJopDetailsData({
    this.id,
    this.title,
    this.description,
    this.location,
    this.deadline,
    this.priceStartAt,
    this.priceEndAt,
    this.poster,
    this.isMine,
  });

  factory UserJopDetailsData.fromJson(Map<String, dynamic> json) => UserJopDetailsData(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    location: json["location"],
    deadline: json["deadline"],
    priceStartAt: json["price_start_at"],
    priceEndAt: json["price_end_at"],
    poster: json["poster"] == null ? null : Poster.fromJson(json["poster"]),
    isMine: json["is_mine"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "location": location,
    "deadline": deadline,
    "price_start_at": priceStartAt,
    "price_end_at": priceEndAt,
    "poster": poster?.toJson(),
    "is_mine": isMine,
  };
}

class Poster {
  int? id;
  String? name;
  String? image;
  dynamic headline;
  int? followersCount;

  Poster({
    this.id,
    this.name,
    this.image,
    this.headline,
    this.followersCount,
  });

  factory Poster.fromJson(Map<String, dynamic> json) => Poster(
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
