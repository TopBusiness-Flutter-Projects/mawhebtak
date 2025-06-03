

class UserJobModel {
    List<UserJobModelData>? data;
    Links? links;
    Meta? meta;
    String? msg;
    int? status;

    UserJobModel({
        this.data,
        this.links,
        this.meta,
        this.msg,
        this.status,
    });

    factory UserJobModel.fromJson(Map<String, dynamic> json) => UserJobModel(
        data: json["data"] == null ? [] : List<UserJobModelData>.from(json["data"]!.map((x) => UserJobModelData.fromJson(x))),
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

class UserJobModelData {
    int? id;
    String? title;
    String? description;
    String? location;
    String? deadline;
    bool? isMine;
    bool? isFav;

    UserJobModelData({
        this.id,
        this.title,
        this.description,
        this.location,
        this.deadline,
        this.isMine,
        this.isFav,
    });

    factory UserJobModelData.fromJson(Map<String, dynamic> json) => UserJobModelData(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        location: json["location"],
        deadline: json["deadline"],
        isMine: json["is_mine"],
        isFav: json["is_fav"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "location": location,
        "deadline": deadline,
        "is_mine": isMine,
        "is_fav": isFav,
    };
}

class Links {
    String? first;
    String? last;
    dynamic prev;
    String? next;

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
