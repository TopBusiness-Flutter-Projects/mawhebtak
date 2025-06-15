import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? id; // Add this field for message ID
  String? bodyMessage;
  String? chatId;
  String? receiverId;
  String? senderId;
  Timestamp? time;

  MessageModel({
    this.id, // Include in constructor
    this.bodyMessage,
    this.chatId,
    this.receiverId,
    this.senderId,
    this.time,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String?, // Add ID parsing
      bodyMessage: json['bodyMessage'] as String?,
      chatId: json['chatId'] as String?,
      receiverId: json['receiverId'] as String?,
      senderId: json['senderId'] as String?,
      time: json['time'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, // Include ID in JSON
      'bodyMessage': bodyMessage,
      'chatId': chatId,
      'receiverId': receiverId,
      'senderId': senderId,
      'time': time,
    };
  }
}
