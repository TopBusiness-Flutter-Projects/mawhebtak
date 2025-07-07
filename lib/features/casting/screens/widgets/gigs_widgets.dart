import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/features/casting/cubit/casting_cubit.dart';
import 'package:mawhebtak/features/casting/cubit/casting_state.dart';
import 'package:mawhebtak/features/casting/screens/gigs_details.dart';
import 'package:mawhebtak/features/events/screens/details_event_screen.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/image_view_file.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/video_player_widget.dart';
import 'package:mawhebtak/features/casting/data/model/request_gigs_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/exports.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../../core/utils/check_login.dart';
import '../../../../core/widgets/custom_button.dart';

class GigsWidget extends StatefulWidget {
  const GigsWidget({
    super.key,
    this.eventAndGigsModel,
    this.castingCubit,
    this.isFromDetails = false,
  });
  final EventAndGigsModel? eventAndGigsModel;
  final CastingCubit? castingCubit;
  final bool? isFromDetails;

  @override
  State<GigsWidget> createState() => _GigsWidgetState();
}

class _GigsWidgetState extends State<GigsWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  @override
  initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaList = widget.eventAndGigsModel?.media;
    final mediaCount = mediaList?.length ?? 0;
    return BlocBuilder<CastingCubit, CastingState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: GestureDetector(
            onTap: () {
              if (widget.isFromDetails == false) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GigsDetailsScreen(
                          id: DeepLinkDataModel(
                              id: widget.eventAndGigsModel?.id.toString() ?? "",
                              isDeepLink: false)),
                    ));
              }
            },
            child: Container(
              color: AppColors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.profileRoute,
                                    arguments: DeepLinkDataModel(
                                        id: widget.eventAndGigsModel?.user?.id
                                                .toString() ??
                                            "",
                                        isDeepLink: false));
                              },
                              child: SizedBox(
                                height: 40.h,
                                width: 40.w,
                                child: widget.eventAndGigsModel?.user?.image ==
                                        null
                                    ? Image.asset(ImageAssets.profileImage)
                                    : ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl: widget.eventAndGigsModel
                                                  ?.user?.image ??
                                              '',
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator(
                                                strokeWidth: 2),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                  ImageAssets.profileImage),
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  widget.eventAndGigsModel?.user?.name ?? "",
                                  style: getMediumStyle(fontSize: 18.sp),
                                ),
                                AutoSizeText(
                                  widget.eventAndGigsModel?.user?.headline ??
                                      "",
                                  style: getRegularStyle(
                                    fontSize: 16.sp,
                                    color: AppColors.grayLight,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // if (widget.eventAndGigsModel?.isMine == true)
                        //   PopupMenuButton<String>(
                        //     icon: SvgPicture.asset(AppIcons.settingIcon),
                        //     onSelected: (value) {
                        //       if (value == 'delete') {
                        //         widget.castingCubit?.deleteGigs(
                        //             index: widget.index!,
                        //             gigId: widget.eventAndGigsModel?.id
                        //                     .toString() ??
                        //                 "",
                        //             context: context);
                        //       }
                        //     },
                        //     color: AppColors.white,
                        //     itemBuilder: (BuildContext context) =>
                        //         <PopupMenuEntry<String>>[
                        //       PopupMenuItem<String>(
                        //         value: 'delete',
                        //         child: Text('delete_post'.tr()),
                        //       ),
                        //     ],
                        //   )
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      (mediaCount > 0)
                          ? SizedBox(
                              height: getHeightSize(context) / 3.7,
                              child: PageView.builder(
                                controller: _pageController,
                                itemCount: mediaCount,
                                itemBuilder: (context, index) {
                                  final media = mediaList?[index];
                                  if (media?.extension == 'video') {
                                    return VideoPlayerWidget(
                                        videoUrl: media?.file ?? "");
                                  } else {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ImageFileView(
                                              isNetwork: true,
                                              image: media?.file ?? "",
                                            ),
                                          ),
                                        );
                                      },
                                      child: Image.network(
                                        media?.file ?? '',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Image.asset(
                                                    ImageAssets.appIconWhite),
                                      ),
                                    );
                                  }
                                },
                              ),
                            )
                          : const SizedBox(),
                      if (mediaCount > 1)
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: AnimatedSmoothIndicator(
                              activeIndex: _currentPage,
                              count: mediaCount,
                              effect: const WormEffect(
                                dotHeight: 8,
                                dotWidth: 8,
                                activeDotColor: Colors.white,
                                dotColor: Colors.white60,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  30.h.verticalSpace,
                  Padding(
                    padding: EdgeInsets.only(left: 15.0.w, right: 15.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.eventAndGigsModel?.title ?? "",
                          maxLines: (widget.isFromDetails == true) ? null : 3,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                          ),
                        ),
                        5.h.verticalSpace,
                        Text(
                          widget.eventAndGigsModel?.description ?? "",
                          maxLines: (widget.isFromDetails == true) ? null : 2,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.sp,
                            color: AppColors.blackLite,
                          ),
                        ),
                        20.h.verticalSpace,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(AppIcons.locationIcon),
                                  5.w.horizontalSpace,
                                  Flexible(
                                    child: Text(
                                      widget.eventAndGigsModel?.location ?? "",
                                      maxLines: (widget.isFromDetails == true)
                                          ? null
                                          : 1,
                                      style: TextStyle(
                                          color: AppColors.grayDarkkk,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  5.w.horizontalSpace,

                                  if (widget.eventAndGigsModel?.price == "0" ||
                                      widget.eventAndGigsModel?.price?.toLowerCase() == "free") ...[
                                    Flexible(
                                      child: AutoSizeText(
                                        "free".tr(),
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ] else if (widget.eventAndGigsModel?.discount != null &&
                                      widget.eventAndGigsModel?.discount != "0" &&
                                      widget.eventAndGigsModel?.priceAfterDiscount != null) ...[
                                    Flexible(
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: AutoSizeText(
                                              widget.eventAndGigsModel!.price!,
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14.sp,
                                                decoration: TextDecoration.lineThrough,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          8.w.horizontalSpace,
                                          Flexible(
                                            child: AutoSizeText(
                                              widget.eventAndGigsModel!.priceAfterDiscount!,
                                              style: TextStyle(
                                                color: AppColors.primary,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ] else ...[
                                    Flexible(
                                      child: AutoSizeText(
                                        widget.eventAndGigsModel?.price ?? "",
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),


                          ],
                        ),
                      ],
                    ),
                  ),
                  10.verticalSpace,
                  if (widget.eventAndGigsModel?.isMine == false ||
                      (widget.eventAndGigsModel?.isRequested == "accepted"))
                    Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: CustomButton(
                          color: (widget.eventAndGigsModel?.isRequested ==
                                  "pending")
                              ? AppColors.red
                              : (widget.eventAndGigsModel?.isRequested ==
                                      "accepted")
                                  ? AppColors.blueLight
                                  : AppColors.primary,
                          onTap: () async {
                            final user =
                                await Preferences.instance.getUserModel();
                            if (user.data?.token == null) {
                              checkLogin(context);
                            } else {
                              if (widget.eventAndGigsModel?.isRequested
                                          .toString() ==
                                      "pending" ||
                                  widget.eventAndGigsModel?.isRequested
                                          .toString() ==
                                      "rejected" ||
                                  widget.eventAndGigsModel?.isRequested
                                          .toString() ==
                                      "null") {
                                widget.castingCubit!.requestGigs(
                                  eventAndGigsModel: widget.eventAndGigsModel??
                                      EventAndGigsModel(),
                                  context: context,
                                  chatName: widget.eventAndGigsModel?.user?.name
                                          ?.toString() ??
                                      '',
                                  type: widget.eventAndGigsModel?.isRequested
                                          .toString() ??
                                      "",

                                );
                              }
                            }
                          },
                          title: (widget.eventAndGigsModel?.isRequested ==
                                  "pending")
                              ? "cancel".tr()
                              : (widget.eventAndGigsModel?.isRequested ==
                                      "accepted")
                                  ? "accept".tr()
                                  : "request_this_gigs".tr(),
                        )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
