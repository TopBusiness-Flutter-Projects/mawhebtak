import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/core/widgets/custom_container_with_shadow.dart';
import 'package:mawhebtak/features/announcement/cubit/announcement_cubit.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/image_view_file.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/video_player_widget.dart';
import 'package:mawhebtak/features/home/data/models/home_model.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/exports.dart';
import '../../../events/screens/details_event_screen.dart';

class CustomAnnouncementWidget extends StatefulWidget {
  const CustomAnnouncementWidget({
    super.key,
    this.announcement,
    required this.isMainWidget,
    required this.index,
  });
  final Announcement? announcement;
  final bool isMainWidget;
  final int index;

  @override
  State<CustomAnnouncementWidget> createState() =>
      _CustomAnnouncementWidgetState();
}

class _CustomAnnouncementWidgetState extends State<CustomAnnouncementWidget> {
  @override
  void initState() {
    context.read<AnnouncementCubit>().loadUserFromPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnnouncementCubit, AnnouncementState>(
        builder: (context, state) {
      var cubit = context.read<AnnouncementCubit>();
      return InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.detailsAnnouncementScreen,
              arguments: {
                'announcementId': widget.announcement?.id.toString(),
                "isDeeplink": false
              });
        },
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: 10.w,
            end: 10.0.w,
          ),
          child: CustomContainerWithShadow(
            isShadow: false,
            reduis: 8.r,
            width: 299.w,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: 20.h, top: 10.h, left: 10.w, right: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (widget.announcement?.user?.image == null)
                          ? GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.profileRoute,
                                  arguments: DeepLinkDataModel(
                                      id: widget.announcement?.user?.id
                                              .toString() ??
                                          '',
                                      isDeepLink: false),
                                );
                              },
                              child: SizedBox(
                                height: 40.h,
                                width: 40.w,
                                child: Image.asset(ImageAssets.profileImage),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.profileRoute,
                                  arguments: DeepLinkDataModel(
                                      id: widget.announcement?.user?.id
                                              .toString() ??
                                          '',
                                      isDeepLink: false),
                                );
                              },
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    widget.announcement?.user?.image ?? ""),
                              ),
                            ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                    widget.announcement?.user?.name ?? "",
                                    style: getMediumStyle(fontSize: 16.sp)),
                                AutoSizeText(
                                  widget.announcement?.user?.headline ?? "",
                                  style: getRegularStyle(
                                      fontSize: 14.sp,
                                      color: AppColors.grayLight),
                                ),
                              ],
                            ),
                            if (widget.isMainWidget == true)
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      cubit.toggleFavoriteAnnounce(
                                          context: context,
                                          announcement:widget.announcement??Announcement(),
                                          );
                                    },
                                    child: Icon(
                                      (widget.announcement?.isFav)!
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 20.sp,
                                      color: (widget.announcement?.isFav)!
                                          ? AppColors.primary
                                          : AppColors.lbny.withOpacity(0.5),
                                    ),
                                  ),
                                  if (cubit.user?.data?.id.toString() ==
                                      cubit.announcements?.data?[widget.index]
                                          .user?.id
                                          .toString())
                                    PopupMenuButton<String>(
                                      icon: SvgPicture.asset(
                                          AppIcons.settingIcon),
                                      onSelected: (value) {
                                        if (value == 'delete') {
                                          cubit.deleteAnnouncement(
                                              announcementId: widget
                                                      .announcement?.id
                                                      .toString() ??
                                                  "");
                                        }
                                      },
                                      color: AppColors.white,
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuEntry<String>>[
                                        PopupMenuItem<String>(
                                          value: 'delete',
                                          child: Text('delete_announcement'.tr()),
                                        ),
                                      ],
                                    )
                                ],
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                  ((widget.announcement?.media?.isNotEmpty ??
                          false || widget.announcement?.media == []))
                      ? Expanded(
                          child: SizedBox(
                            height: getHeightSize(context) / 3.7,
                            child: PageView.builder(
                              itemCount:
                                  widget.announcement?.media?.length ?? 0,
                              itemBuilder: (context, index) {
                                final media =
                                    widget.announcement!.media![index];
                                if (media.extension == 'video') {
                                  return VideoPlayerWidget(
                                      videoUrl: media.file!);
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ImageFileView(
                                                      isNetwork: true,
                                                      image: widget
                                                              .announcement
                                                              ?.media?[index]
                                                              .file ??
                                                          "")));
                                    },
                                    child: Image.network(
                                      media.file ?? '',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      errorBuilder: (context, error,
                                              stackTrace) =>
                                          Image.asset(ImageAssets.appIconWhite),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        )
                      : Expanded(child: Image.asset(ImageAssets.appIconWhite)),
                  SizedBox(height: 8.h),
                  AutoSizeText(widget.announcement?.title ?? "",
                      maxLines: 1,
                      style: getSemiBoldStyle(
                          fontSize: 14.sp, color: AppColors.grayDark)),
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SvgPicture.asset(AppIcons.locationIcon),
                            SizedBox(width: 3.w),
                            Expanded(
                              child: Text(
                                widget.announcement?.location ?? "",
                                style: getRegularStyle(
                                    color: AppColors.grayLight,
                                    fontSize: 14.sp),
                              ),
                            ),
                          ],
                        ),
                      ),Row(
                        children: [
                          if (widget.announcement?.priceAfterDiscount != null &&
                              widget.announcement?.priceAfterDiscount != widget.announcement?.price)
                            Row(
                              children: [
                                AutoSizeText(
                                  "${widget.announcement?.price}",
                                  style: getRegularStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey,
                                  ).copyWith(decoration: TextDecoration.lineThrough),
                                ),
                                SizedBox(width: 4.w),
                                AutoSizeText(
                                  "${widget.announcement?.priceAfterDiscount}",
                                  style: getRegularStyle(
                                    fontSize: 16.sp,
                                    color: AppColors.blueLight,
                                  ),
                                ),
                              ],
                            )
                          else
                            AutoSizeText(
                              "${widget.announcement?.price ?? ''}",
                              style: getRegularStyle(
                                fontSize: 14.sp,
                                color: AppColors.blueLight,
                              ),
                            ),
                        ],
                      )

                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
