
class SeeAllEventModel {
  List<Datum>? data;
  String? msg;
  int? status;

  SeeAllEventModel({
    this.data,
    this.msg,
    this.status,
  });

  factory SeeAllEventModel.fromJson(Map<String, dynamic> json) => SeeAllEventModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
    "status": status,
  };
}

class Datum {
  int? id;
  String? image;
  String? title;
  String? description;
  String? from;

  Datum({
    this.id,
    this.image,
    this.title,
    this.description,
    this.from,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
