// To parse this JSON data, do
//
//     final mainRegisterUserTypes = mainRegisterUserTypesFromJson(jsonString);

import 'dart:convert';

import 'package:mawhebtak/features/calender/data/model/countries_model.dart';

MainRegisterUserTypes mainRegisterUserTypesFromJson(String str) => MainRegisterUserTypes.fromJson(json.decode(str));

String mainRegisterUserTypesToJson(MainRegisterUserTypes data) => json.encode(data.toJson());

class MainRegisterUserTypes {
    List<GetCountriesMainModelData>? data;
    String? msg;
    int? status;

    MainRegisterUserTypes({
        this.data,
        this.msg,
        this.status,
    });

    factory MainRegisterUserTypes.fromJson(Map<String, dynamic> json) => MainRegisterUserTypes(
        data: json["data"] == null ? [] : List<GetCountriesMainModelData>.from(json["data"]!.map((x) => GetCountriesMainModelData.fromJson(x))),
        msg: json["msg"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
        "status": status,
    };
}


