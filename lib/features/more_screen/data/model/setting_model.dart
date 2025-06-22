// To parse this JSON data, do
//
//     final settingModel = settingModelFromJson(jsonString);

import 'dart:convert';

SettingModel settingModelFromJson(String str) =>
    SettingModel.fromJson(json.decode(str));

String settingModelToJson(SettingModel data) => json.encode(data.toJson());

class SettingModel {
  SettingModelData? data;
  String? msg;
  int? status;

  SettingModel({
    this.data,
    this.msg,
    this.status,
  });

  factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
        data: json["data"] == null
            ? null
            : SettingModelData.fromJson(json["data"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "msg": msg,
        "status": status,
      };
}

class SettingModelData {
  String? aboutUs;
  String? terms;
  String? developmentMode;
  String? appMentainance;
  String? androidAppVersion;
  String? iosAppVersion;

  SettingModelData({
    this.aboutUs,
    this.terms,
    this.developmentMode,
    this.appMentainance,
    this.androidAppVersion,
    this.iosAppVersion,
  });

  factory SettingModelData.fromJson(Map<String, dynamic> json) =>
      SettingModelData(
        aboutUs: json["about_us"],
        terms: json["terms"],
        developmentMode: json["development_mode"],
        appMentainance: json["app_mentainance"],
        androidAppVersion: json["android_app_version"],
        iosAppVersion: json["ios_app_version"],
      );

  Map<String, dynamic> toJson() => {
        "about_us": aboutUs,
        "terms": terms,
        "development_mode": developmentMode,
        "app_mentainance": appMentainance,
        "android_app_version": androidAppVersion,
        "ios_app_version": iosAppVersion,
      };
}
