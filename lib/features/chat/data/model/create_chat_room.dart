import '../../../home/data/models/home_model.dart';

class MainCreateChatRoomModel {
  MainCreateChatRoomModelData? data;
  String? msg;
  int? status;

  MainCreateChatRoomModel({
    this.data,
    this.msg,
    this.status,
  });

  factory MainCreateChatRoomModel.fromJson(Map<String, dynamic> json) =>
      MainCreateChatRoomModel(
        data: json["data"] == null
            ? null
            : MainCreateChatRoomModelData.fromJson(json["data"]),
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "msg": msg,
        "status": status,
      };
}

class MainCreateChatRoomModelData {
  int? id;
  String? roomToken;
  TopTalent? sender;
  TopTalent? receiver;

  MainCreateChatRoomModelData({
    this.id,
    this.roomToken,
    this.sender,
    this.receiver,
  });

  factory MainCreateChatRoomModelData.fromJson(Map<String, dynamic> json) =>
      MainCreateChatRoomModelData(
        id: json["id"],
        roomToken: json["room_token"],
        sender:
            json["sender"] == null ? null : TopTalent.fromJson(json["sender"]),
        receiver: json["receiver"] == null
            ? null
            : TopTalent.fromJson(json["receiver"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "room_token": roomToken,
        "sender": sender?.toJson(),
        "receiver": receiver?.toJson(),
      };
}
