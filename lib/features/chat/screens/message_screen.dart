import 'dart:developer';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/notification_services/notification_service.dart';

import 'package:mawhebtak/features/chat/cubit/chat_cubit.dart';
import 'package:mawhebtak/features/chat/cubit/chat_state.dart';
import 'package:mawhebtak/features/chat/screens/widgets/chat_bubble_widget.dart';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import '../../../core/preferences/preferences.dart';
import '../../../core/widgets/show_loading_indicator.dart';
import '../../auth/login/data/models/login_model.dart';

class MainUserAndRoomChatModel {
  String? receiverId;
  String? chatId;

  MainUserAndRoomChatModel({this.receiverId, this.chatId});
}

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key, required this.model});
  final MainUserAndRoomChatModel model;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  void initState() {
    userModel = null;
    super.initState();
    MessageStateManager().enterChatRoom(widget.model.chatId ?? '');
    log('999999999 ${widget.model.chatId}');
    log('8888888888 ${widget.model.receiverId.toString()}');
    if (widget.model.chatId != null) {
      log('999999999 8888888888 ${widget.model.chatId}');

      context.read<ChatCubit>().listenForMessages(widget.model.chatId ?? '');
    } else {
      context.read<ChatCubit>().createChatRoom(
            receiverId: widget.model.receiverId!,
          );
    }
    getUserData();
  }

  LoginModel? userModel;
  void getUserData() async {
    userModel = await Preferences.instance.getUserModel();
  }

  @override
  dispose() {
    super.dispose();
    MessageStateManager().leaveChatRoom(widget.model.chatId ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        var cubit = context.read<ChatCubit>();
        return Scaffold(
          appBar: AppBar(),
          body: (state is LoadingGetNewMessagteState)
              ? const Center(
                  child: CustomLoadingIndicator(),
                )
              : Column(
                  children: [
                    // App Bar with Image

                    // Chat Messages Area
                    Expanded(
                        child: ListView.builder(
                      controller: cubit.scrollController,
                      itemCount: cubit.messages.length,
                      reverse: true,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                      itemBuilder: (context, index) {
                        var item = cubit.messages[index];
                        return ChatBubble(
                          isSender: (userModel?.data?.id.toString() ==
                              item.senderId.toString()),
                          message: item.bodyMessage ?? '',
                          time: item.time!,
                        );
                      },
                    )
                        // : Container(),
                        ),
                    // Input Field
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border(
                          top: BorderSide(
                              color: AppColors.gray.withOpacity(0.5)),
                        ),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              _showBottomSheet(context, cubit);
                            },
                            icon: Icon(
                              Icons.emoji_emotions_outlined,
                              color: AppColors.gray,
                              size: 24.sp * textScaleFactor(context),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: cubit.messageController,
                              decoration: InputDecoration(
                                hintText: "write_msg".tr(),
                                hintStyle: TextStyle(color: AppColors.gray),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 5.h),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    20.sp * textScaleFactor(context),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: AppColors.gray.withOpacity(0.1),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed:
                                //  (state is LoadingCreateChatRoomState ||
                                //         state is LoadingCreate2ChatRoomState)
                                //     ? () {}
                                //     :
                                () {
                              if (cubit.messageController.text.isNotEmpty) {
                                log('0000 : ${widget.model.chatId ?? cubit.createChatRoomModel?.data?.roomToken ?? ''}');
                                cubit.sendMessage(
                                  receiverId: widget.model.receiverId,
                                  chatId: widget.model.chatId ??
                                      cubit.createChatRoomModel?.data
                                          ?.roomToken ??
                                      '',
                                );
                              }
                            },
                            icon: SvgPicture.asset(AppIcons.sendIcon),
                          ),
                          /*  IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                enableDrag: true,
                                builder: (context) {
                                  return Container(
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              cubit.pickImage(
                                                context,
                                                isGallery: false,
                                                chatId: widget.model.chatId ??
                                                    cubit.createChatRoomModel
                                                        ?.data?.uuid ??
                                                    '',
                                              );
                                            },
                                            child: Text('Camera')),
                                        TextButton(
                                            onPressed: () {
                                              cubit.pickImage(
                                                context,
                                                isGallery: true,
                                                chatId: widget.model.chatId ??
                                                    cubit.createChatRoomModel
                                                        ?.data?.uuid ??
                                                    '',
                                              );
                                            },
                                            child: Text('Gallary')),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SvgPicture.asset(
                                ImageAssets.attachIcon,
                                color: AppColors.gray,
                              ),
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context, ChatCubit cubit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to adjust its height
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom:
                MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
          ),
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Ensures the column takes minimal space
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      icon: Icon(
                        Icons.close,
                        color: AppColors.gray,
                        size: 24.sp * textScaleFactor(context),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: cubit.messageController,
                        decoration: InputDecoration(
                          hintText: "write_msg".tr(),
                          hintStyle: TextStyle(color: AppColors.gray),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 5.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              20.sp * textScaleFactor(context),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: AppColors.gray.withOpacity(0.1),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        log('0000 : ${widget.model.chatId ?? cubit.createChatRoomModel?.data?.roomToken ?? ''}');
                        cubit.sendMessage(
                          receiverId: widget.model.receiverId,
                          chatId: widget.model.chatId ??
                              cubit.createChatRoomModel?.data?.roomToken ??
                              '',
                        );
                      },
                      icon: SvgPicture.asset(AppIcons.sendIcon),
                    ),
                  ],
                ),
              ),
              Offstage(
                offstage: cubit.isEmojiVisible,
                child: SizedBox(
                  height: 300.h,
                  child: EmojiPicker(
                    onEmojiSelected: (category, emoji) {
                      cubit.messageController.text += emoji.emoji;
                    },
                    textEditingController: cubit.messageController,
                    config: Config(
                      bottomActionBarConfig: BottomActionBarConfig(
                        backgroundColor: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
