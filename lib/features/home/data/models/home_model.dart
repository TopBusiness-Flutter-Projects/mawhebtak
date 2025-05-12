
class HomeModel {
  Data? data;
  String? msg;
  int? status;

  HomeModel({
    this.data,
    this.msg,
    this.status,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
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
  List<Slider>? sliders;
  List<UserSlider>? userSliders;
  List<dynamic>? topTalents;
  List<Top>? topEvents;
  List<Top>? topGigs;

  Data({
    this.sliders,
    this.userSliders,
    this.topTalents,
    this.topEvents,
    this.topGigs,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    sliders: json["sliders"] == null ? [] : List<Slider>.from(json["sliders"]!.map((x) => Slider.fromJson(x))),
    userSliders: json["user_sliders"] == null ? [] : List<UserSlider>.from(json["user_sliders"]!.map((x) => UserSlider.fromJson(x))),
    topTalents: json["top_talents"] == null ? [] : List<dynamic>.from(json["top_talents"]!.map((x) => x)),
    topEvents: json["top_events"] == null ? [] : List<Top>.from(json["top_events"]!.map((x) => Top.fromJson(x))),
    topGigs: json["top_gigs"] == null ? [] : List<Top>.from(json["top_gigs"]!.map((x) => Top.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sliders": sliders == null ? [] : List<dynamic>.from(sliders!.map((x) => x.toJson())),
    "user_sliders": userSliders == null ? [] : List<dynamic>.from(userSliders!.map((x) => x.toJson())),
    "top_talents": topTalents == null ? [] : List<dynamic>.from(topTalents!.map((x) => x)),
    "top_events": topEvents == null ? [] : List<dynamic>.from(topEvents!.map((x) => x.toJson())),
    "top_gigs": topGigs == null ? [] : List<dynamic>.from(topGigs!.map((x) => x.toJson())),
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

class Top {
  int? id;
  String? image;
  String? title;
  String? description;
  String? from;

  Top({
    this.id,
    this.image,
    this.title,
    this.description,
    this.from,
  });

  factory Top.fromJson(Map<String, dynamic> json) => Top(
    id: json["id"],
    image: json["image"],
    title: json["title"],
    description: json["description"],
    from: json["from"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "title": title,
    "description": description,
    "from": from,
  };
}

class UserSlider {
  int? id;
  String? name;
  String? image;
  dynamic headline;
  int? followersCount;

  UserSlider({
    this.id,
    this.name,
    this.image,
    this.headline,
    this.followersCount,
  });

  factory UserSlider.fromJson(Map<String, dynamic> json) => UserSlider(
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
