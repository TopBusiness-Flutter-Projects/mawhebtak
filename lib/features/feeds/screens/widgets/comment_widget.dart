import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/core/widgets/see_more_text.dart';

import '../../../../core/exports.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../../core/utils/check_login.dart';
import '../../cubit/feeds_cubit.dart';
import '../../cubit/feeds_state.dart';
import '../../data/models/posts_model.dart';

class MainCommentWidget extends StatefulWidget {
  const MainCommentWidget({
    super.key,
    this.feeds,
    this.feedsCubit,
    required this.postId,
    required this.index,
  });
  final PostsModelData? feeds;
  final FeedsCubit? feedsCubit;
  final String postId;
  final int index;

  @override
  State<MainCommentWidget> createState() => _MainCommentWidgetState();
}

class _MainCommentWidgetState extends State<MainCommentWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedsCubit, FeedsState>(builder: (context, state) {
      return GestureDetector(
        onTap: () async {
          final user = await Preferences.instance.getUserModel();
          if (user.data?.token == null) {
            checkLogin(context);
          } else {
            context.read<FeedsCubit>().commentsData(postId: widget.postId);
            showModalBottomSheet(
              showDragHandle: true,
              useSafeArea: true,
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              backgroundColor: AppColors.white,
              builder: (context) {
                return FractionallySizedBox(
                  heightFactor: 0.7,
                  child: BlocBuilder<FeedsCubit, FeedsState>(
                    builder: (context, state) {
                      final comments = widget.feedsCubit?.comments?.data ?? [];
                      return SafeArea(
                        child: Column(
                          children: [
                            10.h.verticalSpace,
                            Text(
                              'comments'.tr(),
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            10.h.verticalSpace,
                            Expanded(
                              child: ListView.builder(
                                controller: widget.feedsCubit?.scrollController,
                                itemCount: comments.length,
                                itemBuilder: (context, index) {
                                  var comment = comments[index];
                                  var user = comment.user;
                                  var replies = comment.reply ?? [];
                                  return Card(
                                    color: AppColors.white,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 6.h),
                                    elevation: 0.5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.w),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(comment
                                                                    .user
                                                                    ?.image ??
                                                                ''),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(user?.name ?? "",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      18.sp)),
                                                          ExpandableTextWidget(
                                                              text: comment
                                                                      .comment ??
                                                                  "",
                                                              fontSize: 16.sp),
                                                          Row(
                                                            children: [
                                                              replies.isEmpty
                                                                  ? Container()
                                                                  : TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        context
                                                                            .read<FeedsCubit>()
                                                                            .isOpen(comment);
                                                                      },
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Icon(
                                                                            comment.showReplies == true
                                                                                ? Icons.keyboard_arrow_up_outlined
                                                                                : Icons.keyboard_arrow_down_outlined,
                                                                            color:
                                                                                AppColors.primary,
                                                                          ),
                                                                          Text(
                                                                            '${replies.isEmpty ? '' : replies.length} ${'replies'.tr()}',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 16.sp,
                                                                              color: AppColors.primary,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  context
                                                                      .read<
                                                                          FeedsCubit>()
                                                                      .startReplying(
                                                                        comment
                                                                            .id
                                                                            .toString(),
                                                                        user?.name ??
                                                                            '',
                                                                      );
                                                                },
                                                                child: Text(
                                                                  'reply'.tr(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        16.sp,
                                                                    color: AppColors
                                                                        .primary,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if (widget.feedsCubit?.user?.data
                                                      ?.id ==
                                                  comment.user?.id)
                                                PopupMenuButton<String>(
                                                  color: AppColors.white,
                                                  icon: SvgPicture.asset(
                                                      AppIcons.settingIcon),
                                                  onSelected: (value) {
                                                    if (value == 'delete') {
                                                      widget.feedsCubit
                                                          ?.deleteComment(
                                                              commentId: comment
                                                                  .id
                                                                  .toString(),
                                                              postId: widget
                                                                  .postId);
                                                    }
                                                  },
                                                  itemBuilder: (BuildContext
                                                          context) =>
                                                      <PopupMenuEntry<String>>[
                                                    PopupMenuItem<String>(
                                                      value: 'delete',
                                                      child: Text(
                                                          'delete_comment'
                                                              .tr()),
                                                    ),
                                                  ],
                                                )
                                            ],
                                          ),
                                          if (comment.showReplies == true)
                                            ...replies.map((reply) {
                                              final replyUser = reply.user;
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    left: EasyLocalization.of(
                                                                    context)!
                                                                .currentLocale
                                                                ?.languageCode ==
                                                            'en'
                                                        ? 60.w
                                                        : 0.w,
                                                    right: EasyLocalization.of(
                                                                    context)!
                                                                .currentLocale
                                                                ?.languageCode ==
                                                            'ar'
                                                        ? 60.w
                                                        : 0.w,
                                                    top: 6.h),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 16.r,
                                                      backgroundImage:
                                                          NetworkImage(
                                                        replyUser?.image ??
                                                            'https://i.pravatar.cc/150?img=2',
                                                      ),
                                                    ),
                                                    10.w.horizontalSpace,
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              replyUser?.name ??
                                                                  "",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      16.sp)),
                                                          ExpandableTextWidget(
                                                            text: reply.reply ??
                                                                "",
                                                            fontSize: 16.sp,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 8.h),
                              child: BlocBuilder<FeedsCubit, FeedsState>(
                                builder: (context, state) {
                                  final cubit = context.read<FeedsCubit>();
                                  final isReplying =
                                      cubit.replyingToCommentId != null;

                                  return Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          style: TextStyle(fontSize: 18.sp),
                                          controller: cubit.commentController,
                                          decoration: InputDecoration(
                                            hintText: isReplying
                                                ? "${'repling_to'.tr()} @${cubit.replyingToUserName}"
                                                : "write_comment".tr(),
                                            filled: true,
                                            fillColor: AppColors.grayLight
                                                .withOpacity(0.5),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              borderSide: BorderSide.none,
                                            ),
                                            suffixIcon: isReplying
                                                ? IconButton(
                                                    icon:
                                                        const Icon(Icons.close),
                                                    onPressed:
                                                        cubit.cancelReplying,
                                                  )
                                                : null,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 16.w,
                                                    vertical: 10.h),
                                          ),
                                        ),
                                      ),
                                      6.w.horizontalSpace,
                                      IconButton(
                                        icon: Icon(Icons.send,
                                            color: AppColors.primary),
                                        onPressed: () {
                                          if (widget
                                                  .feedsCubit
                                                  ?.commentController
                                                  .text
                                                  .isEmpty ??
                                              false) {
                                            errorGetBar("enter_comment");
                                          } else {
                                            if (isReplying) {
                                              cubit.addReply(
                                                postId: widget.postId,
                                                postCommentId:
                                                    cubit.replyingToCommentId!,
                                              );
                                              cubit.cancelReplying();
                                            } else {
                                              cubit.addComment(
                                                  postId: widget.postId);
                                            }
                                          }
                                        },
                                      )
                                    ],
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                AppIcons.commentIcon,
                width: 20.sp,
                color: AppColors.grayDarkkk,
              ),
            ),
            Text(
              'comment'.tr(),
              style: getRegularStyle(
                fontSize: 16.sp,
                color: AppColors.grayDate,
              ),
            ),
          ],
        ),
      );
    });
  }
}
