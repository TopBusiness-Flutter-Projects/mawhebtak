import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mawhebtak/core/widgets/see_more_text.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_cubit.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_state.dart';
import 'package:mawhebtak/features/feeds/data/models/posts_model.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/image_view_file.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/video_player_widget.dart';
import '../../../../core/exports.dart';

class TimeLineList extends StatefulWidget {
  const TimeLineList({
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
  State<TimeLineList> createState() => _TimeLineListState();
}

class _TimeLineListState extends State<TimeLineList> {
  @override
  void initState() {
    context.read<FeedsCubit>().getUserFromPreferences();
    context.read<FeedsCubit>().loadUserFromPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.only(bottom: 10.h, top: 10.h, right: 10.w, left: 10.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 40.h,
                        width: 40.w,
                        child: Image.asset(ImageAssets.profileImage),
                      ),
                    ],
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        widget.feeds?.user?.name ?? "",
                        style: getMediumStyle(fontSize: 18.sp),
                      ),
                      AutoSizeText(
                        widget.feeds?.user?.headline ?? "Telent / Actor Expert",
                        style: getRegularStyle(
                          fontSize: 16.sp,
                          color: AppColors.grayLight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (widget.feedsCubit?.user?.data?.id.toString() ==
                  widget.feedsCubit?.posts?.data?[widget.index].user?.id
                      .toString())
                PopupMenuButton<String>(
                  icon: SvgPicture.asset(AppIcons.settingIcon),
                  onSelected: (value) {
                    if (value == 'delete') {
                      widget.feedsCubit?.deletePost(postId: widget.postId);
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'delete',
                      child: Text('Delete Post'),
                    ),
                  ],
                )
            ],
          ),
        ),
        //profile desc
        Padding(
          padding: EdgeInsets.only(left: 10.0.w),
          child: ExpandableTextWidget(
            text: widget.feeds?.body ?? "",
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        if ((widget.feeds?.media?.isNotEmpty ?? false))
          SizedBox(
            height: getHeightSize(context) / 3.7,
            child: PageView.builder(
              itemCount: widget.feeds?.media?.length ?? 0,
              itemBuilder: (context, index) {
                final media = widget.feeds!.media![index];
                if (media.extension == 'video') {
                  return VideoPlayerWidget(videoUrl: media.file!);
                } else {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageFileView(
                                  isNetwork: true,
                                  image:
                                      widget.feeds!.media![index].file ?? "")));
                    },
                    child: Image.network(
                      media.file ?? '',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset(ImageAssets.appIconWhite),
                    ),
                  );
                }
              },
            ),
          ),
        SizedBox(height: 5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.feeds?.reactionCount != 0)
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      AppIcons.likeIcon,
                      width: 20,
                    ),
                  ),
                  Text(
                    widget.feeds?.reactionCount.toString() ?? "0",
                    style: getSemiBoldStyle(
                      fontSize: 16.sp,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            if (widget.feeds?.commentCount != 0)
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${widget.feeds?.commentCount.toString()}  ${'comment'.tr()}",
                      style: getRegularStyle(
                        fontSize: 18.sp,
                        color: AppColors.grayDark.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 3.h),
        Container(
          height: 2.h,
          color: AppColors.grayLite,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                widget.feedsCubit
                    ?.addReaction(postId: widget.postId, index: widget.index);
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      AppIcons.likeIcon,
                      width: 20.sp,
                      color: widget.feedsCubit?.posts?.data?[widget.index]
                                  .isReacted ==
                              true
                          ? AppColors.primary
                          : AppColors.grayDarkkk,
                    ),
                  ),
                  Text(
                    'like'.tr(),
                    style: getRegularStyle(
                      fontSize: 18.sp,
                      color: AppColors.grayDate,
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<FeedsCubit, FeedsState>(builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  context
                      .read<FeedsCubit>()
                      .commentsData(postId: widget.postId);
                  showModalBottomSheet(
                    showDragHandle: true,
                    useSafeArea: true,
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    backgroundColor: AppColors.white,
                    builder: (context) {
                      return FractionallySizedBox(
                        heightFactor: 0.7,
                        child: BlocBuilder<FeedsCubit, FeedsState>(
                          builder: (context, state) {
                            final comments =
                                widget.feedsCubit?.comments?.data ?? [];
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
                                      controller:
                                          widget.feedsCubit?.scrollController,
                                      itemCount: comments.length,
                                      itemBuilder: (context, index) {
                                        final comment = comments[index];
                                        final user = comment.user;
                                        final replies = comment.reply ?? [];

                                        return Card(
                                          color: AppColors.white,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 12.w, vertical: 6.h),
                                          elevation: 1,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(10.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                            user?.image ??
                                                                'https://i.pravatar.cc/150?img=1',
                                                          ),
                                                        ),
                                                        10.w.horizontalSpace,
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                    user?.name ??
                                                                        "",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            18.sp)),
                                                                Text(
                                                                    comment.comment ??
                                                                        "",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16.sp)),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {},
                                                                  child: Text(
                                                                    '${replies.length} replies',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18.sp,
                                                                      color: AppColors
                                                                          .primary,
                                                                    ),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
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
                                                                    'reply',
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
                                                      ],
                                                    ),
                                                    if (widget.feedsCubit?.user
                                                            ?.data?.id ==
                                                        comment.user?.id)
                                                      PopupMenuButton<String>(
                                                        icon: SvgPicture.asset(
                                                            AppIcons
                                                                .settingIcon),
                                                        onSelected: (value) {
                                                          if (value ==
                                                              'delete') {
                                                            widget.feedsCubit
                                                                ?.deleteComment(
                                                                    commentId:
                                                                        comment
                                                                            .id
                                                                            .toString(),
                                                                    postId: widget
                                                                        .postId);
                                                          }
                                                        },
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context) =>
                                                                <PopupMenuEntry<
                                                                    String>>[
                                                          const PopupMenuItem<
                                                              String>(
                                                            value: 'delete',
                                                            child: Text(
                                                                'Delete Post'),
                                                          ),
                                                        ],
                                                      )
                                                  ],
                                                ),
                                                ...replies.map((reply) {
                                                  final replyUser = reply.user;
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20.w, top: 6.h),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
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
                                                                  replyUser
                                                                          ?.name ??
                                                                      "",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16.sp)),
                                                              Text(
                                                                  reply.reply ??
                                                                      "",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14.sp)),
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
                                        final cubit =
                                            context.read<FeedsCubit>();
                                        final isReplying =
                                            cubit.replyingToCommentId != null;

                                        return Row(
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                style:
                                                    TextStyle(fontSize: 18.sp),
                                                controller:
                                                    cubit.commentController,
                                                decoration: InputDecoration(
                                                  hintText: isReplying
                                                      ? "Replying to @${cubit.replyingToUserName}"
                                                      : "Write a comment...",
                                                  filled: true,
                                                  fillColor: AppColors.grayLight
                                                      .withOpacity(0.5),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.r),
                                                    borderSide: BorderSide.none,
                                                  ),
                                                  suffixIcon: isReplying
                                                      ? IconButton(
                                                          icon: const Icon(
                                                              Icons.close),
                                                          onPressed: cubit
                                                              .cancelReplying,
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
                                                      postCommentId: cubit
                                                          .replyingToCommentId!,
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
            }),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    AppIcons.shareIcon2,
                    width: 20.sp,
                    color: AppColors.grayDarkkk,
                  ),
                ),
                Text(
                  'share'.tr(),
                  style: getRegularStyle(
                    fontSize: 18.sp,
                    color: AppColors.grayDate,
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          color: AppColors.grayLite,
          height: 10.h,
        )
      ],
    );
  }
}
