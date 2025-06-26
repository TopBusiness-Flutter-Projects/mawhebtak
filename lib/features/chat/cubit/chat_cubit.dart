import 'dart:developer';

import 'package:mawhebtak/core/exports.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/preferences/preferences.dart';
import '../data/model/create_chat_room.dart';
import '../data/model/message_model.dart';
import '../data/model/room_model.dart';
import '../data/repos/chat_repo.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chatRepo) : super(ChatInitial());
  ChatRepo chatRepo;

  //! Firebase

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController messageController = TextEditingController();
  List<MessageModel> messages = [];
  void listenForMessages(String chatId) {
    emit(LoadingGetNewMessagteState());
    _firestore
        .collection('rooms')
        .doc(chatId)
        .collection('messages')
        .orderBy('time', descending: true)
        .snapshots()
        .listen((snapshot) {
      messages = snapshot.docs
          .map((doc) => MessageModel.fromJson(doc.data()))
          .toList();

      emit(ChatLoaded(messages));
    });
  }

  //////////!

//////////!
  Future<void> sendMessage({
    required String chatId,
    required String? receiverId,
  }) async {
    try {
      final userModel = await Preferences.instance.getUserModel();

      final messageRef = _firestore
          .collection('rooms')
          .doc(chatId)
          .collection('messages')
          .doc();

      final message = MessageModel(
        id: messageRef.id,
        bodyMessage: messageController.text,
        chatId: chatId,
        senderId: userModel.data?.id?.toString(),
        receiverId: receiverId,
        time: Timestamp.now(),
      );

      await messageRef.set(message.toJson());

      messageController.clear();
    } catch (e) {
      log('Error sending message: $e');
      emit(MessageErrorState());
    }
  }

  Future<void> deleteMessage(
      {required String chatId, required String messageId}) async {
    try {
      await _firestore
          .collection('rooms')
          .doc(chatId)
          .collection('messages')
          .doc(messageId)
          .delete();

      messages.removeWhere((message) => message.id == messageId);
      emit(ChatLoaded(messages));
    } catch (e) {
      log('Error deleting message: $e');
      emit(MessageErrorState());
    }
  }

  bool isEmojiVisible = false;
  void toggleEmojiKeyboard() {
    isEmojiVisible = !isEmojiVisible;
    emit(OntoggleEmojiSocietyState());
  }

  ScrollController scrollController = ScrollController();

  void listenForMessagesWithScroll() {
    scrollController.animateTo(
      0,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  //////////!

  MainCreateChatRoomModel? createChatRoomModel;

  void createChatRoom({String? receiverId}) async {
    emit(LoadingCreateChatRoomState());
    final res = await chatRepo.createChatRoom(receiverId: receiverId);

    res.fold((l) {
      emit(ErrorCreateChatRoomState());
    }, (r) {
      messages = [];
      listenForMessages(r.data?.roomToken ?? '');
      createChatRoomModel = r;
      emit(LoadedCreateChatRoomState());
    });
  }

  MainChatsModel? chatRoomModel;
  void getChatRooms() async {
    emit(LoadingCreateChatRoomState());
    final res = await chatRepo.getChatRooms();
    res.fold((l) {
      emit(ErrorCreateChatRoomState());
    }, (r) {
      chatRoomModel = r;
      emit(LoadedCreateChatRoomState());
    });
  }

  // File? pickedImage;

  // /// Pick image from gallery or camera
  // Future<void> pickImage(BuildContext context,
  //     {required bool isGallery, String? chatId}) async {
  //   try {
  //     final picker = ImagePicker();
  //     final pickedFile = await picker.pickImage(
  //       source: isGallery ? ImageSource.gallery : ImageSource.camera,
  //     );
  //     if (pickedFile != null) {
  //       pickedImage = File(pickedFile.path);
  //       sendMessageWithImage(chatId: chatId);
  //     } else {
  //       emit(FilePickCancelled());
  //     }
  //   } catch (e) {
  //     emit(UpdateProfileError());
  //   } finally {
  //     Navigator.pop(context);
  //   }
  // }

  // void sendMessage({String? chatId}) async {
  //   emit(LoadingCreateChatRoomState());
  //   final res = await chatRepo.sendMessage(
  //     chatId: chatId,
  //     message: messageController.text,
  //   );

  //   res.fold((l) {
  //     emit(ErrorCreateChatRoomState());
  //   }, (r) {
  //     messageController.clear();

  //     listenForMessages(chatId ?? '');
  //     listenForMessagesWithScroll();

  //     emit(LoadedCreateChatRoomState());
  //   });
  // }
}

String extractTimeFromTimestamp(Timestamp timestamp) {
  // Convert Firestore Timestamp to DateTime
  DateTime dateTime = timestamp.toDate();

  // Create formatter for local timezone (or specify specific zone)
  DateFormat outputFormat = DateFormat('h:mm a');

  // Return formatted time string
  return outputFormat.format(dateTime);
}
