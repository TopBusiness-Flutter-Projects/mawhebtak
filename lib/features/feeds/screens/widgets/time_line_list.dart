import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mawhebtak/core/widgets/see_more_text.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_cubit.dart';
import 'package:mawhebtak/features/feeds/data/models/posts_model.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/image_view_file.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/video_player_widget.dart';
import '../../../../core/exports.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../../core/utils/check_login.dart';
import 'comment_widget.dart';

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
            padding: EdgeInsets.only(
                bottom: 10.h, top: 10.h, right: 10.w, left: 10.w),
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
                            child: widget.feeds?.user?.image == null
                                ? Image.asset(ImageAssets.profileImage)
                                : ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: widget.feeds?.user?.image ?? '',
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(ImageAssets.profileImage),
                                    ),
                                  ),
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
                            widget.feeds?.user?.headline ?? "",
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
                      color: AppColors.white,
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'delete',
                          child: Text('delete_post'.tr()),
                        ),
                      ],
                    )
                ])),
        //profile desc
        Padding(
            padding: EdgeInsets.only(left: 10.0.w),
            child: ExpandableTextWidget(text: widget.feeds?.body ?? "")),
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
                    child: CachedNetworkImage(
                      imageUrl: media.file ?? '',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorWidget: (context, error, stackTrace) =>
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
            (widget.feeds?.reactionCount == 0)
                ? Container()
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
              Align(
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
              onTap: () async {
                final user = await Preferences.instance.getUserModel();
                if (user.data?.token == null) {
                  checkLogin(context);
                } else {
                  widget.feedsCubit
                      ?.addReaction(postId: widget.postId, index: widget.index);
                }
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
                      color: widget.feedsCubit?.posts?.data?[widget.index]
                                  .isReacted ==
                              true
                          ? AppColors.primary
                          : AppColors.grayDate,
                    ),
                  ),
                ],
              ),
            ),

            ///! Comment
            MainCommentWidget(
                index: widget.index,
                postId: widget.postId,
                feeds: widget.feeds,
                feedsCubit: widget.feedsCubit),
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
