import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/exports.dart';
import '../../cubit/chat_cubit.dart';

class ChatBubble extends StatefulWidget {
  ChatBubble({
    super.key,
    required this.isSender,
    this.message,
    this.id,
    this.chatId,
    required this.time,
    this.image,
  });

  bool isSender;
  String? message;
  String? image;
  Timestamp time;
  String? id;
  String? chatId;

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  @override
  void initState() {
    log(widget.image.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Uri? uri = Uri.tryParse(widget.image ?? '');
    print('555 ${uri!.host.isNotEmpty}');
    return GestureDetector(
      onLongPress: () {
        if (widget.isSender == true) {
          deleteAccountDialog(context,
              title: "delete_account_desc_message".tr(), onPressed: () {
            context.read<ChatCubit>().deleteMessage(
                chatId: widget.chatId.toString(),
                messageId: widget.id.toString());
          });
        }
      },
      child: SizedBox(
        child: Align(
          alignment:
              widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: widget.isSender
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              (uri.host.isNotEmpty)
                  ? ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 1.4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(imageUrl: widget.image!),
                        ],
                      ),
                    )
                  : widget.message == null
                      ? Container()
                      : ConstrainedBox(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width / 1.4),
                          child: Container(
                            // width: MediaQuery.of(context).size.width / 1.4,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            margin: EdgeInsets.symmetric(vertical: 5.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: widget.isSender
                                  ? AppColors.primary
                                  : AppColors.gray.withOpacity(0.2),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  10.sp * textScaleFactor(context),
                                ),
                                topRight: Radius.circular(
                                  10.sp * textScaleFactor(context),
                                ),
                                bottomLeft: widget.isSender
                                    ? Radius.circular(
                                        10.sp * textScaleFactor(context),
                                      )
                                    : Radius.zero,
                                bottomRight: widget.isSender
                                    ? Radius.zero
                                    : Radius.circular(
                                        10.sp * textScaleFactor(context),
                                      ),
                              ),
                            ),
                            child: Text(
                              widget.message ?? '',
                              style: getRegularStyle(
                                fontSize: 14.sp * textScaleFactor(context),
                                color: widget.isSender
                                    ? AppColors.white
                                    : AppColors.black,
                              ),
                            ),
                          ),
                        ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  extractTimeFromTimestamp(widget.time),
                  style: getRegularStyle(
                    fontSize: 12.sp,
                    color: AppColors.gray,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
