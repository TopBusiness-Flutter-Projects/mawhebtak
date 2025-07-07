import 'package:mawhebtak/features/casting/data/model/request_gigs_model.dart';
import 'package:mawhebtak/features/events/data/model/event_details_model.dart';

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

  Map<String, dynamic> toJson() =>
      {"data": data?.toJson(), "msg": msg, "status": status};
}

class HomeData {
  bool? seeAllNotification;
  Slider? sliders;
  List<TopTalent>? userSliders;
  List<TopTalent>? topTalents;
  List<EventAndGigsModel>? topEvents;
  List<GigCategory>? topGigs;
  List<Announcement>? announcements;

  HomeData({
    this.sliders,
    this.userSliders,
    this.topTalents,
    this.topEvents,
    this.topGigs,
    this.announcements,
    this.seeAllNotification,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
        seeAllNotification: json["is_i_see_all_notifications"],
        sliders: (json["sliders"].isEmpty ||
                json["sliders"] == null ||
                json["sliders"] is List)
            ? null
            : Slider.fromJson(json["sliders"]),
        userSliders:
            (json["user_sliders"] == null || json["user_sliders"] == [])
                ? []
                : List<TopTalent>.from(
                    json["user_sliders"]!.map((x) => TopTalent.fromJson(x))),
        topTalents: (json["top_talents"] == null || json["top_talents"] == [])
            ? []
            : List<TopTalent>.from(
                json["top_talents"]!.map((x) => TopTalent.fromJson(x))),
        topEvents: (json["top_events"] == null || json["top_events"] == [])
            ? []
            : List<EventAndGigsModel>.from(
                json["top_events"]!.map((x) => EventAndGigsModel.fromJson(x))),
        topGigs: (json["gig_category"] == null || json["gig_category"] == [])
            ? []
            : List<GigCategory>.from(
                json["gig_category"]!.map((x) => GigCategory.fromJson(x))),
        announcements: (json["announcements"] == null ||
                json["announcements"] == [])
            ? []
            : List<Announcement>.from(
                json["announcements"]!.map((x) => Announcement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "is_i_see_all_notifications": seeAllNotification,
        "sliders": sliders?.toJson(),
        "user_sliders": (userSliders == null || userSliders == [])
            ? []
            : List<dynamic>.from(userSliders!.map((x) => x.toJson())),
        "top_talents": topTalents == null
            ? []
            : List<dynamic>.from(topTalents!.map((x) => x.toJson())),
        "top_events": topEvents == null
            ? []
            : List<dynamic>.from(topEvents!.map((x) => x.toJson())),
        "gig_category": topGigs == null
            ? []
            : List<dynamic>.from(topGigs!.map((x) => x.toJson())),
        "announcements": announcements == null
            ? []
            : List<dynamic>.from(announcements!.map((x) => x.toJson())),
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
  String? discount;
  String? priceAfterDiscount;
  bool? isFav;
  bool? isMine;
  List<Media>? media;

  Announcement({
    this.id,
    this.user,
    this.image,
    this.isMine,
    this.title,
    this.description,
    this.location,
    this.price,
    this.discount,
    this.priceAfterDiscount,
    this.isFav,
    this.media,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
        id: json["id"],
        user: json["user"] == null ? null : TopTalent.fromJson(json["user"]),
        image: json["image"],
        title: json["title"],
        isMine: json["is_mine"],
        description: json["description"],
        location: json["location"],
        price: json["price"],
        discount: json["discount"],
        priceAfterDiscount: json["price_after_discount"],
        isFav: json["is_fav"],
        media: json["media"] == null
            ? []
            : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "image": image,
        "title": title,
        "description": description,
        "location": location,
        "price": price,
        "discount": discount,
        "price_after_discount": priceAfterDiscount,
        "is_fav": isFav,
        "is_mine": isMine,
        "media": media == null
            ? []
            : List<dynamic>.from(media!.map((x) => x.toJson())),
      };
}

class TopTalent {
  int? id;
  String? name;
  String? image;
  dynamic headline;
  int? followersCount;
  String? referralCode;
  int? isPhoneHidden;
  bool? isIFollow;
  int? isDeleteOrdered;

  TopTalent({
    this.id,
    this.name,
    this.image,
    this.headline,
    this.followersCount,
    this.referralCode,
    this.isPhoneHidden,
    this.isIFollow,
    this.isDeleteOrdered,
  });

  factory TopTalent.fromJson(Map<String, dynamic> json) => TopTalent(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        headline: json["headline"],
        followersCount: json["followers_count"],
        referralCode: json["referral_code"],
        isPhoneHidden: json["is_phone_hidden"],
        isIFollow: json["is_i_follow"],
        isDeleteOrdered: json["is_delete_ordered"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "headline": headline,
        "followers_count": followersCount,
        "referral_code": referralCode,
        "is_phone_hidden": isPhoneHidden,
        "is_i_follow": isIFollow,
        "is_delete_ordered": isDeleteOrdered,
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

class GigCategory {
  int? id;
  String? name;

  GigCategory({
    this.id,
    this.name,
  });

  factory GigCategory.fromJson(Map<String, dynamic> json) => GigCategory(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
