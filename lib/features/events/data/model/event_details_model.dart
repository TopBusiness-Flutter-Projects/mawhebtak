class GetMainEvenDetailsModel {
  GetMainEvenDetailsModelData? data;
  String? msg;
  int? status;

  GetMainEvenDetailsModel({
    this.data,
    this.msg,
    this.status,
  });

  factory GetMainEvenDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetMainEvenDetailsModel(
        data: json["data"] == null
            ? null
            : GetMainEvenDetailsModelData.fromJson(json["data"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "msg": msg,
        "status": status,
      };
}

class GetMainEvenDetailsModelData {
  int? id;
  String? title;
  String? description;
  String? from;
  String? to;
  EventOwner? eventOwner;
  String? location;
  String? lat;
  String? long;
  int? isPublic;
  String? category;
  String? eventLimit;
  String? eventPrice;
  int? isFree;
  int? enrolled;
  int? revenu;
  bool? isFollowed;
  bool? isRequested;
  bool? isMine;
  List<Media>? media;
  List<Requirement>? requirements;
  List<EventOwner>? enrolledUsers;
  List<EventRequest>? eventRequests;

  GetMainEvenDetailsModelData({
    this.id,
    this.title,
    this.description,
    this.from,
    this.to,
    this.eventOwner,
    this.location,
    this.lat,
    this.long,
    this.isPublic,
    this.category,
    this.eventLimit,
    this.eventPrice,
    this.isFree,
    this.enrolled,
    this.revenu,
    this.isFollowed,
    this.isRequested,
    this.isMine,
    this.media,
    this.requirements,
    this.enrolledUsers,
    this.eventRequests,
  });

  factory GetMainEvenDetailsModelData.fromJson(Map<String, dynamic> json) =>
      GetMainEvenDetailsModelData(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        from: json["from"],
        to: json["to"],
        eventOwner: json["event_owner"] == null
            ? null
            : EventOwner.fromJson(json["event_owner"]),
        location: json["location"],
        lat: json["lat"],
        long: json["long"],
        isPublic: json["is_public"],
        category: json["category"],
        eventLimit: json["event_limit"],
        eventPrice: json["event_price"],
        isFree: json["is_free"],
        enrolled: json["enrolled"],
        revenu: json["revenu"],
        isFollowed: json["is_followed"],
        isRequested: json["is_requested"],
        isMine: json["is_mine"],
        media: json["media"] == null
            ? []
            : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
        requirements: json["requirements"] == null
            ? []
            : List<Requirement>.from(
                json["requirements"]!.map((x) => Requirement.fromJson(x))),
        enrolledUsers: json["enrolled_users"] == null
            ? []
            : List<EventOwner>.from(
                json["enrolled_users"]!.map((x) => EventOwner.fromJson(x))),
        eventRequests: json["event_requests"] == null
            ? []
            : List<EventRequest>.from(
                json["event_requests"]!.map((x) => EventRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "from": from,
        "to": to,
        "event_owner": eventOwner?.toJson(),
        "location": location,
        "lat": lat,
        "long": long,
        "is_public": isPublic,
        "category": category,
        "event_limit": eventLimit,
        "event_price": eventPrice,
        "is_free": isFree,
        "enrolled": enrolled,
        "revenu": revenu,
        "is_followed": isFollowed,
        "is_requested": isRequested,
        "is_mine": isMine,
        "media": media == null
            ? []
            : List<dynamic>.from(media!.map((x) => x.toJson())),
        "requirements": requirements == null
            ? []
            : List<dynamic>.from(requirements!.map((x) => x.toJson())),
        "enrolled_users": enrolledUsers == null
            ? []
            : List<dynamic>.from(enrolledUsers!.map((x) => x.toJson())),
        "event_requests": eventRequests == null
            ? []
            : List<dynamic>.from(eventRequests!.map((x) => x.toJson())),
      };
}

class EventOwner {
  int? id;
  String? name;
  String? image;
  dynamic headline;
  int? followersCount;

  EventOwner({
    this.id,
    this.name,
    this.image,
    this.headline,
    this.followersCount,
  });

  factory EventOwner.fromJson(Map<String, dynamic> json) => EventOwner(
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

class EventRequest {
  int? id;
  String? eventRequirement;
  String? price;
  String? note;
  String? status;
  EventOwner? user;
  List<Media>? media;

  EventRequest({
    this.id,
    this.eventRequirement,
    this.price,
    this.note,
    this.status,
    this.user,
    this.media,
  });

  factory EventRequest.fromJson(Map<String, dynamic> json) => EventRequest(
        id: json["id"],
        eventRequirement: json["event_requirement"],
        price: json["price"],
        note: json["note"],
        status: json["status"],
        user: json["user"] == null ? null : EventOwner.fromJson(json["user"]),
        media: json["media"] == null
            ? []
            : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_requirement": eventRequirement,
        "price": price,
        "note": note,
        "status": status,
        "user": user?.toJson(),
        "media": media == null
            ? []
            : List<dynamic>.from(media!.map((x) => x.toJson())),
      };
}

class Media {
  int? id;
  String? file;
  String? extension;

  Media({
    this.id,
    this.file,
    this.extension,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        file: json["file"],
        extension: json["extension"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file": file,
        "extension": extension,
      };
}

class Requirement {
  int? id;
  String? subCategory;
  String? price;
  String? countryCurrency;

  Requirement({
    this.id,
    this.subCategory,
    this.price,
    this.countryCurrency,
  });

  factory Requirement.fromJson(Map<String, dynamic> json) => Requirement(
        id: json["id"],
        subCategory: json["sub_category"],
        price: json["price"],
        countryCurrency: json["country_currency"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sub_category": subCategory,
        "price": price,
        "country_currency": countryCurrency,
      };
}
