
class PaginationModel {
  String? first;
  String? last;
  String? prev;
  String? next;

  PaginationModel({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) => PaginationModel(
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


