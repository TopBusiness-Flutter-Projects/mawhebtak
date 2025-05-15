
import 'package:mawhebtak/features/home/data/models/request_gigs_model.dart';

class HomeModel {
  HomeData? data;
  String? msg;
  int? status;

  HomeModel({
    this.data,
    this.msg,
    this.status,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    data: json["data"] == null ? null : HomeData.fromJson(json["data"]),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "msg": msg,
    "status": status,
  };
}

class HomeData {
  Slider? sliders;
  List<TopTalent>? userSliders;
  List<TopTalent>? topTalents;
  List<EventAndGigsModel>? topEvents;
  List<EventAndGigsModel>? topGigs;
  List<Announcement>? announcements;

  HomeData({
    this.sliders,
    this.userSliders,
    this.topTalents,
    this.topEvents,
    this.topGigs,
    this.announcements,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
    sliders: json["sliders"] == null ? null : Slider.fromJson(json["sliders"]),
    userSliders: json["user_sliders"] == null ? [] : List<TopTalent>.from(json["user_sliders"]!.map((x) => TopTalent.fromJson(x))),
    topTalents: json["top_talents"] == null ? [] : List<TopTalent>.from(json["top_talents"]!.map((x) => TopTalent.fromJson(x))),
    topEvents: json["top_events"] == null ? [] : List<EventAndGigsModel>.from(json["top_events"]!.map((x) => EventAndGigsModel.fromJson(x))),
    topGigs: json["top_gigs"] == null ? [] : List<EventAndGigsModel>.from(json["top_gigs"]!.map((x) => EventAndGigsModel.fromJson(x))),
    announcements: json["announcements"] == null ? [] : List<Announcement>.from(json["announcements"]!.map((x) => Announcement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sliders": sliders?.toJson(),
    "user_sliders": userSliders == null ? [] : List<dynamic>.from(userSliders!.map((x) => x.toJson())),
    "top_talents": topTalents == null ? [] : List<dynamic>.from(topTalents!.map((x) => x.toJson())),
    "top_events": topEvents == null ? [] : List<dynamic>.from(topEvents!.map((x) => x.toJson())),
    "top_gigs": topGigs == null ? [] : List<dynamic>.from(topGigs!.map((x) => x.toJson())),
    "announcements": announcements == null ? [] : List<dynamic>.from(announcements!.map((x) => x.toJson())),
  };
}

class Announcement {
  int? id;
  TopTalent? user;
  String? image;
  String? title;
  String? description;
  String? location;
  String? price;

  Announcement({
    this.id,
    this.user,
    this.image,
    this.title,
    this.description,
    this.location,
    this.price,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
    id: json["id"],
    user: json["user"] == null ? null : TopTalent.fromJson(json["user"]),
    image: json["image"],
    title: json["title"],
    description: json["description"],
    location: json["location"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user?.toJson(),
    "image": image,
    "title": title,
    "description": description,
    "location": location,
    "price": price,
  };
}

class TopTalent {
  int? id;
  String? name;
  String? image;
  dynamic headline;
  int? followersCount;

  TopTalent({
    this.id,
    this.name,
    this.image,
    this.headline,
    this.followersCount,
  });

  factory TopTalent.fromJson(Map<String, dynamic> json) => TopTalent(
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

class Slider {
  int? id;
  String? name;
  String? image;
  String? url;
  String? urlType;

  Slider({
    this.id,
    this.name,
    this.image,
    this.url,
    this.urlType,
  });

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    url: json["url"],
    urlType: json["url_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "url": url,
    "url_type": urlType,
  };
}


