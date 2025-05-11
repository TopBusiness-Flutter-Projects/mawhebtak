class DefaultMainModel {
  dynamic data;
  String? msg;
  int? status;

  DefaultMainModel({
    this.data,
    this.msg,
    this.status,
  });

  factory DefaultMainModel.fromJson(Map<String, dynamic> json) =>
      DefaultMainModel(
        data: json["status"] != 200 ? null : json["data"],
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "msg": msg,
        "status": status,
      };
}
