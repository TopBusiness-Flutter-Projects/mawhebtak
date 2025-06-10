import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/core/widgets/custom_container_with_shadow.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/image_view_file.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/video_player_widget.dart';
import 'package:mawhebtak/features/home/screens/widgets/follow_button.dart';
import '../../../core/exports.dart';
import '../cubit/announcement_cubit.dart';

class DetailsAnnouncementScreen extends StatefulWidget {
  const DetailsAnnouncementScreen({super.key, required this.announcementId});
  final String announcementId;
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
    var cubit = context.read<AnnouncementCubit>();
    return Scaffold(
        backgroundColor: AppColors.grayLite,
        body: BlocBuilder<AnnouncementCubit, AnnouncementState>(
            builder: (BuildContext context, state) {
          return (state is AnnouncementsDetailsStateLoading ||
                  cubit.announcementDetailsModel == null)
              ? const Center(child: CustomLoadingIndicator())
              : Padding(
                  padding: EdgeInsets.only(right: 0.w, left: 0.w),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomSimpleAppbar(title: "details".tr()),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: getHeightSize(context) / 22),
                              Padding(
                                padding:
                                    EdgeInsets.only(right: 10.w, left: 10.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    (cubit.announcementDetailsModel?.data?.user
                                                ?.image ==
                                            null)
                                        ? SizedBox(
                                            height: 40.h,
                                            width: 40.w,
                                            child: Image.asset(
                                                ImageAssets.profileImage),
                                          )
                                        : CircleAvatar(
                                            backgroundImage: NetworkImage(cubit
                                                    .announcementDetailsModel!
                                                    .data!
                                                    .user
                                                    ?.image ??
                                                ""),
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
                                                    color: AppColors.grayLight),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    cubit.announcementDetailsModel!
                                                            .data!.isFav =
                                                        !(cubit
                                                            .announcementDetailsModel!
                                                            .data!
                                                            .isFav)!;
                                                  });
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
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SvgPicture.asset(
                                                    AppIcons.settingIcon),
                                              ),
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
                                                                          ?.media?[
                                                                              index]
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
                                            cubit.announcementDetailsModel?.data
                                                    ?.title ??
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
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                    AppIcons.dollarSign),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: AutoSizeText(
                                                    "${cubit.announcementDetailsModel?.data?.price} L.E",
                                                    style: getRegularStyle(
                                                        fontSize: 14.sp,
                                                        color: AppColors
                                                            .blueLight),
                                                  ),
                                                )
                                              ],
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
                              Padding(
                                  padding: EdgeInsets.all(10.w),
                                  child: CustomContainerButton(
                                      color: AppColors.primary,
                                      title: "request_this_product".tr(),
                                      height: 50.h))
                            ])
                      ]));
        }));
  }
}
