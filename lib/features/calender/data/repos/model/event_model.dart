import '../../../../casting/data/model/request_gigs_model.dart';

class GetMainEventModel {
  List<EventAndGigsModel>? data;
  String? msg;
  int? status;

  GetMainEventModel({
    this.data,
    this.msg,
    this.status,
  });

  factory GetMainEventModel.fromJson(Map<String, dynamic> json) =>
      GetMainEventModel(
        data: json["data"] == null
            ? []
            : List<EventAndGigsModel>.from(
                json["data"]!.map((x) => EventAndGigsModel.fromJson(x))),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<EventAndGigsModel>.from(data!.map((x) => x.toJson())),
        "msg": msg,
        "status": status,
      };
}
