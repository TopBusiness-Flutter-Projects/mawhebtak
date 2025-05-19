
class PostsModel {
  List<PostsModelData>? data;
  Links? links;
  Meta? meta;
  String? msg;
  int? status;

  PostsModel({
    this.data,
    this.links,
    this.meta,
    this.msg,
    this.status,
  });

  factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
    data: json["data"] == null ? [] : List<PostsModelData>.from(json["data"]!.map((x) => PostsModelData.fromJson(x))),
    links: json["links"] == null ? null : Links.fromJson(json["links"]),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    msg: json["msg"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links?.toJson(),
    "meta": meta?.toJson(),
    "msg": msg,
    "status": status,
  };
}

class PostsModelData {
  int? id;
  User? user;
  String? body;
  int? commentCount;
  int? reactionCount;
  bool? isReacted;
  List<Media>? media;



  PostsModelData({
    this.id,
    this.user,
    this.body,
    this.commentCount,
    this.reactionCount,
    this.isReacted,
    this.media,

  });

  factory PostsModelData.fromJson(Map<String, dynamic> json) => PostsModelData(
    id: json["id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    body: json["body"],
    commentCount: json["comment_count"],
    reactionCount: json["reaction_count"],
    isReacted: json["is_reacted"],
    media: json["media"] == null ? [] : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),


  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user?.toJson(),
    "body": body,
    "comment_count": commentCount,
    "reaction_count": reactionCount,
    "is_reacted": isReacted,
    "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x.toJson())),


  };
}
class Media {
  int? id;
  String? file;
  String? extension;
  int? size;

  Media({
    this.id,
    this.file,
    this.extension,
    this.size,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    id: json["id"],
    file: json["file"],
    extension: json["extension"],
    size: json["size"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "file": file,
    "extension": extension,
    "size": size,
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

class Links {
  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
