
class AddNewGigModel {
  Data? data;
  String? msg;
  int? status;

  AddNewGigModel({
    this.data,
    this.msg,
    this.status,
  });

  factory AddNewGigModel.fromJson(Map<String, dynamic> json) => AddNewGigModel(
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
  String? image;
  List<Media>? media;
  String? title;
  String? description;
  String? location;
  String? price;

  Data({
    this.id,
    this.image,
    this.media,
    this.title,
    this.description,
    this.location,
    this.price,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    image: json["image"],
    media: json["media"] == null ? [] : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
    title: json["title"],
    description: json["description"],
    location: json["location"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x.toJson())),
    "title": title,
    "description": description,
    "location": location,
    "price": price,
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
