import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/widgets/custom_container_with_shadow.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/events/screens/details_event_screen.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/image_view_file.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/video_player_widget.dart';
import 'package:mawhebtak/features/home/screens/widgets/follow_button.dart';
import '../../../core/exports.dart';
import '../../chat/screens/message_screen.dart';
import '../cubit/announcement_cubit.dart';

class DetailsAnnouncementScreen extends StatefulWidget {
  const DetailsAnnouncementScreen({
    super.key,
    required this.announcementId,
    required this.isDeeplink,
  });
  final String announcementId;

  final bool isDeeplink;
  @override
  State<DetailsAnnouncementScreen> createState() =>
      _DetailsAnnouncementScreenState();
}

class _DetailsAnnouncementScreenState extends State<DetailsAnnouncementScreen> {
  @override
  void initState() {
    context.read<AnnouncementCubit>().getDetailsAnnouncements(
        announcementId: widget.announcementId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.grayLite,
        body: BlocBuilder<AnnouncementCubit, AnnouncementState>(
            builder: (BuildContext context, state) {
          var cubit = context.read<AnnouncementCubit>();

          return (state is AnnouncementsDetailsStateLoading ||
                  cubit.announcementDetailsModel == null)
              ? const Center(child: CustomLoadingIndicator())
              : Padding(
                  padding: EdgeInsets.only(right: 0.w, left: 0.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomSimpleAppbar(title: "details".tr()),
                        Container(
                          color: AppColors.white,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: getHeightSize(context) / 22),
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: 10.w, left: 10.w),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            Routes.profileRoute,
                                            arguments: DeepLinkDataModel(
                                              id: cubit.announcementDetailsModel?.data?.user?.id?.toString() ?? "",
                                              isDeepLink: false,
                                            ),
                                          );
                                        },
                                        child: ClipOval(
                                          child: (cubit.announcementDetailsModel?.data?.user?.image == null ||
                                              cubit.announcementDetailsModel!.data!.user!.image!.isEmpty)
                                              ? Image.asset(
                                            ImageAssets.profileImage,
                                            width: 40.w,
                                            height: 40.h,
                                            fit: BoxFit.cover,
                                          )
                                              : Image.network(
                                            cubit.announcementDetailsModel!.data!.user!.image!,
                                            width: 40.w,
                                            height: 40.h,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Image.asset(
                                                ImageAssets.profileImage,
                                                width: 40.w,
                                                height: 40.h,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AutoSizeText(
                                                    cubit.announcementDetailsModel!
                                                            .data!.user?.name ??
                                                        "",
                                                    style: getMediumStyle(
                                                        fontSize: 16.sp)),
                                                AutoSizeText(
                                                  cubit.announcementDetailsModel!
                                                          .data!.user?.headline ??
                                                      "",
                                                  style: getRegularStyle(
                                                      fontSize: 14.sp,
                                                      color:
                                                          AppColors.grayLight),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    cubit
                                                        .toggleFavoriteAnnounce(
                                                      announcement: cubit
                                                          .announcementDetailsModel!
                                                          .data!,
                                                      context: context,
                                                    );
                                                  },
                                                  child: Icon(
                                                    (cubit.announcementDetailsModel!
                                                            .data!.isFav)!
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    size: 20.sp,
                                                    color: (cubit
                                                            .announcementDetailsModel!
                                                            .data!
                                                            .isFav)!
                                                        ? AppColors.primary
                                                        : AppColors.lbny
                                                            .withOpacity(0.5),
                                                  ),
                                                ),
                                                if (cubit.user?.data?.id
                                                            .toString() ==
                                                        cubit
                                                            .announcementDetailsModel
                                                            ?.data
                                                            ?.user
                                                            ?.id
                                                            .toString() &&
                                                    (widget.isDeeplink ==
                                                        false))
                                                  PopupMenuButton<String>(
                                                    icon: SvgPicture.asset(
                                                        AppIcons.settingIcon),
                                                    onSelected: (value) {
                                                      if (value == 'delete') {
                                                        cubit.deleteAnnouncement(
                                                            announcementId: widget
                                                                    .announcementId
                                                                    .toString() ??
                                                                "");
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    color: AppColors.white,
                                                    itemBuilder: (BuildContext
                                                            context) =>
                                                        <PopupMenuEntry<
                                                            String>>[
                                                      PopupMenuItem<String>(
                                                        value: 'delete',
                                                        child: Text(
                                                            'delete_post'.tr()),
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
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    start: 10.w,
                                    end: 16.w,
                                  ),
                                  child: CustomContainerWithShadow(
                                    isShadow: false,
                                    reduis: 8.r,
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 10.h),
                                          if ((cubit.announcementDetailsModel
                                                  ?.data?.media?.isNotEmpty ??
                                              false ||
                                                  cubit.announcementDetailsModel
                                                          ?.data?.media ==
                                                      []))
                                            SizedBox(
                                              height:
                                                  getHeightSize(context) / 3.7,
                                              child: PageView.builder(
                                                itemCount: cubit
                                                        .announcementDetailsModel
                                                        ?.data
                                                        ?.media
                                                        ?.length ??
                                                    0,
                                                itemBuilder: (context, index) {
                                                  final media = cubit
                                                      .announcementDetailsModel!
                                                      .data!
                                                      .media![index];
                                                  if (media.extension ==
                                                      'video') {
                                                    return VideoPlayerWidget(
                                                        videoUrl: media.file!);
                                                  } else {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => ImageFileView(
                                                                    isNetwork:
                                                                        true,
                                                                    image: cubit
                                                                            .announcementDetailsModel
                                                                            ?.data
                                                                            ?.media?[index]
                                                                            .file ??
                                                                        "")));
                                                      },
                                                      child: Image.network(
                                                        media.file ?? '',
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                        errorBuilder: (context,
                                                                error,
                                                                stackTrace) =>
                                                            Image.asset(ImageAssets
                                                                .appIconWhite),
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                          SizedBox(height: 8.h),
                                          AutoSizeText(
                                              cubit.announcementDetailsModel
                                                      ?.data?.title ??
                                                  "",
                                              maxLines: 1,
                                              style: getSemiBoldStyle(
                                                  fontSize: 14.sp,
                                                  color: AppColors.grayDark)),
                                          SizedBox(height: 5.h),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        AppIcons.locationIcon),
                                                    SizedBox(width: 3.w),
                                                    Expanded(
                                                      child: Text(
                                                        cubit.announcementDetailsModel
                                                                ?.data?.location ??
                                                            "",
                                                        style: getRegularStyle(
                                                            color: AppColors
                                                                .grayLight,
                                                            fontSize: 14.sp),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: (cubit.announcementDetailsModel?.data?.priceAfterDiscount != null &&
                                                      cubit.announcementDetailsModel?.data?.priceAfterDiscount !=
                                                          cubit.announcementDetailsModel?.data?.price)
                                                      ? Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Flexible(
                                                        child: AutoSizeText(
                                                          "${cubit.announcementDetailsModel?.data?.price}",
                                                          style: getRegularStyle(
                                                            fontSize: 12.sp,
                                                            color: Colors.grey,
                                                          ).copyWith(decoration: TextDecoration.lineThrough),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(width: 4.w),
                                                      Flexible(
                                                        child: AutoSizeText(
                                                          "${cubit.announcementDetailsModel?.data?.priceAfterDiscount}",
                                                          style: getRegularStyle(
                                                            fontSize: 16.sp,
                                                            color: AppColors.blueLight,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                      : AutoSizeText(
                                                    cubit.announcementDetailsModel?.data?.price?.toString() ?? '',
                                                    style: getRegularStyle(
                                                      fontSize: 14.sp,
                                                      color: AppColors.blueLight,
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              )

                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: 10.w, left: 10.w),
                                  child: Text(
                                    "Description",
                                    style: getSemiBoldStyle(
                                        fontSize: 15.sp,
                                        color: AppColors.darkGray),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: 10.w, left: 10.w),
                                  child: Text(
                                      style: getRegularStyle(
                                          fontSize: 15.sp,
                                          color: AppColors.gray666),
                                      cubit.announcementDetailsModel?.data
                                              ?.description ??
                                          ""),
                                ),
                                SizedBox(height: getHeightSize(context) / 36),
                                if (cubit.announcementDetailsModel?.data
                                        ?.isMine ==
                                    false)
                                  Padding(
                                      padding: EdgeInsets.all(10.w),
                                      child: CustomContainerButton(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, Routes.messageRoute,
                                                arguments: MainUserAndRoomChatModel(
                                                    receiverId: cubit
                                                        .announcementDetailsModel
                                                        ?.data
                                                        ?.user
                                                        ?.id
                                                        ?.toString(),
                                                    chatName: cubit
                                                            .announcementDetailsModel
                                                            ?.data
                                                            ?.user
                                                            ?.name ??
                                                        ''));
                                          },
                                          color: AppColors.primary,
                                          title: "request_this_product".tr(),
                                          height: 50.h))
                              ]),
                        )
                      ]));
        }));
  }
}
