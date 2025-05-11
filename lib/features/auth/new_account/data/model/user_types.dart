// To parse this JSON data, do
//
//     final mainRegisterUserTypes = mainRegisterUserTypesFromJson(jsonString);

import 'dart:convert';

MainRegisterUserTypes mainRegisterUserTypesFromJson(String str) => MainRegisterUserTypes.fromJson(json.decode(str));

String mainRegisterUserTypesToJson(MainRegisterUserTypes data) => json.encode(data.toJson());

class MainRegisterUserTypes {
    List<MainRegisterUserTypesData>? data;
    String? msg;
    int? status;

    MainRegisterUserTypes({
        this.data,
        this.msg,
        this.status,
    });

    factory MainRegisterUserTypes.fromJson(Map<String, dynamic> json) => MainRegisterUserTypes(
        data: json["data"] == null ? [] : List<MainRegisterUserTypesData>.from(json["data"]!.map((x) => MainRegisterUserTypesData.fromJson(x))),
        msg: json["msg"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
        "status": status,
    };
}

class MainRegisterUserTypesData {
    int? id;
    String? name;

    MainRegisterUserTypesData({
        this.id,
        this.name,
    });

    factory MainRegisterUserTypesData.fromJson(Map<String, dynamic> json) => MainRegisterUserTypesData(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
