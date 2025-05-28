class MainCalendarEvent {
  List<MainCalendarEventData>? data;
  String? msg;
  int? status;

  MainCalendarEvent({
    this.data,
    this.msg,
    this.status,
  });

  factory MainCalendarEvent.fromJson(Map<String, dynamic> json) =>
      MainCalendarEvent(
        data: json["data"] == null
            ? []
            : List<MainCalendarEventData>.from(
                json["data"]!.map((x) => MainCalendarEventData.fromJson(x))),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
        "status": status,
      };
}

class MainCalendarEventData {
  int? id;
  String? title;
  DateTime? start;
  DateTime? end;
  String? color;

  MainCalendarEventData({
    this.title,
    this.start,
    this.end,
    this.color,
    this.id,
  });

  factory MainCalendarEventData.fromJson(Map<String, dynamic> json) =>
      MainCalendarEventData(
        title: json["title"],
        id: json["id"],
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        end: json["end"] == null ? null : DateTime.parse(json["end"]),
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "start": start?.toIso8601String(),
        "end": end?.toIso8601String(),
        "color": color,
      };
}
