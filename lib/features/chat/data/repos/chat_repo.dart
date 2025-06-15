import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';

import '../../../../core/exports.dart';

import '../model/create_chat_room.dart';
import '../model/room_model.dart';

class ChatRepo {
  BaseApiConsumer dio;
  ChatRepo(this.dio);

//! :: chat/getChatRooms
  Future<Either<Failure, MainChatsModel>> getChatRooms() async {
    try {
      final response = await dio.get(EndPoints.getChatsUrl);
      log('Get Chat Rooms Response: ${response.toString()}');
      return Right(MainChatsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // Future<Either<Failure, DefaultMainModel>> sendMessage(
  //     {String? chatId, String? message}) async {
  //   try {
  //     log('"file"${file?.path ?? ''}');
  //     final response = await dio
  //         .post(EndPoints.sendMessageUrl,
  //         formDataIsEnabled: true, body: {
  //          "chat_id": chatId,
  //          "message": message,
  //       if (file != null)
  //         "file": MultipartFile.fromFileSync(file.path, filename: file.path),
  //     });
  //     return Right(DefaultMainModel.fromJson(response));
  //   } on ServerException {
  //     return Left(ServerFailure());
  //   }
  // }

  Future<Either<Failure, MainCreateChatRoomModel>> createChatRoom(
      {String? receiverId}) async {
    try {
      final useModel = await Preferences.instance.getUserModel();
      final response = await dio.get(EndPoints.createChatRoomUrl,
          queryParameters: {
            'sender_id': useModel.data?.id?.toString(),
            'receiver_id': receiverId
          });

      return Right(MainCreateChatRoomModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
