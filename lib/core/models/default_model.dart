class DefaultMainModel {
  dynamic data;
  String? msg;
  int? status;
  String? errors;

  DefaultMainModel({
    this.data,
    this.msg,
    this.status,
    this.errors,
  });

  factory DefaultMainModel.fromJson(Map<String, dynamic> json) =>
      DefaultMainModel(
        data: json["status"] != 200 ? null : json["data"],
        msg: json["msg"],
        errors: json["errors"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "msg": msg,
        "errors": errors,
        "status": status,
      };
}
