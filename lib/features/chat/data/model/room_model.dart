import 'create_chat_room.dart';

class MainChatsModel {
  List<MainCreateChatRoomModelData>? data;
  String? msg;
  int? status;

  MainChatsModel({
    this.data,
    this.msg,
    this.status,
  });

  factory MainChatsModel.fromJson(Map<String, dynamic> json) => MainChatsModel(
        data: json["data"] == null
            ? []
            : List<MainCreateChatRoomModelData>.from(json["data"]!
                .map((x) => MainCreateChatRoomModelData.fromJson(x))),
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
