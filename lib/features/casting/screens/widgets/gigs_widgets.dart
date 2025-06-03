import 'dart:developer';
import 'package:flutter_svg/svg.dart';
import 'package:mawhebtak/features/casting/cubit/casting_cubit.dart';
import 'package:mawhebtak/features/casting/cubit/casting_state.dart';
import 'package:mawhebtak/features/casting/screens/gigs_details.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/image_view_file.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/video_player_widget.dart';
import 'package:mawhebtak/features/home/data/models/request_gigs_model.dart';
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
    this.index,
    this.isFromDetails = false,
  });
  final EventAndGigsModel? eventAndGigsModel;
  final CastingCubit? castingCubit;
  final int? index;
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
                        id: widget.eventAndGigsModel?.id.toString() ?? "",
                      ),
                    ));
              }
            },
            child: Container(
              color: AppColors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                          ),
                        ),
                        5.h.verticalSpace,
                        Text(
                          widget.eventAndGigsModel?.description ?? "",
                          maxLines: widget.eventAndGigsModel?.image != null
                              ? 2
                              : null,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.sp,
                            color: AppColors.blackLite,
                          ),
                        ),
                        20.h.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  SvgPicture.asset(AppIcons.locationIcon),
                                  5.w.horizontalSpace,
                                  Flexible(
                                    child: Text(
                                      widget.eventAndGigsModel?.location ?? "",
                                      style: TextStyle(
                                          color: AppColors.grayDarkkk,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(AppIcons.dollar),
                                5.w.horizontalSpace,
                                Text(
                                  widget.eventAndGigsModel?.price.toString() ??
                                      "",
                                  style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  10.verticalSpace,
                  if (widget.eventAndGigsModel?.isMine == false ||
                      (widget.eventAndGigsModel?.isRequested == "accept"))
                    Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: CustomButton(
                            color: widget.eventAndGigsModel?.isRequested ==
                                    "pending"
                                ? AppColors.red
                                : AppColors.primary,
                            onTap: () async {
                              final user =
                                  await Preferences.instance.getUserModel();
                              if (user.data?.token == null) {
                                checkLogin(context);
                              } else {
                                log('sssss ${widget.eventAndGigsModel?.isRequested}');
                                widget.castingCubit?.requestGigs(
                                  context: context,
                                  index: widget.index!,
                                  type: widget.eventAndGigsModel?.isRequested
                                          .toString() ??
                                      "",
                                  gigId:
                                      widget.eventAndGigsModel?.id.toString() ??
                                          "",
                                );
                              }
                            },
                            title: (widget.eventAndGigsModel?.isRequested ==
                                    "pending")
                                ? "cancel".tr()
                                : "request_this_gigs".tr())),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
