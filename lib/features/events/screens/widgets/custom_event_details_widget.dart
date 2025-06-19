import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/exports.dart';
import '../../../home/screens/widgets/follow_button.dart';
import '../../data/model/event_details_model.dart';
import 'custom_media_view.dart';

class CustomEventDetailsWidget extends StatelessWidget {
  CustomEventDetailsWidget(
      {super.key,
      this.onTap,
      this.isFollowed,
      this.isDeepLink,
      required this.mediaList,
      required this.item});
  final void Function()? onTap;
  final bool? isFollowed;
  final List<Media> mediaList;

  bool? isDeepLink;
  final GetMainEvenDetailsModelData? item;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          mediaList.isEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8.r),
                      bottomRight: Radius.circular(8.r)),
                  child: SizedBox(
                    height: 220.h,
                    width: getWidthSize(context),
                    child:
                        Image.asset(ImageAssets.logoImage, fit: BoxFit.cover),
                  ))
              : MediaCarousel(mediaList: mediaList),
          Positioned(
            top: 15.h,
            left: 0,
            right: 0,
            child: CustomSimpleAppbar(
              isActionButton: true,
              actionIcon: AppIcons.shareIcon,
              onShareTap: () async {
                await SharePlus.instance.share(ShareParams(
                  text:
                      AppStrings.eventsShareLink + (item?.id.toString() ?? ''),
                  title: AppStrings.appName,
                ));
              },
              isWithShadow: true,
              isDeepLink: isDeepLink,
              titleColor: AppColors.white,
              colorButton: AppColors.black.withOpacity(0.2),
              title: 'events_details'.tr(),
              filterType: 'event',
              color: AppColors.transparent,
              arrowColor: AppColors.white,
            ),
          ),
          Positioned(
            bottom: 5,
            left: 5.w,
            right: 5.w,
            child: SizedBox(
              width: getWidthSize(context) / .9, // Match image width

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end, // Center vertically
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Center horizontally
                  children: [
                    SizedBox(height: 60.h),
                    Text(
                      item?.title ?? '',
                      style: getMediumStyle(
                        color: AppColors.white,
                        fontSize: 16.sp,
                        isShadow: true,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(AppIcons.calenderIcon),
                                SizedBox(width: 5.w),
                                Expanded(
                                  child: Text(
                                    item?.from ?? '',
                                    style: getRegularStyle(
                                        isShadow: true,
                                        fontSize: 14.sp,
                                        color: AppColors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            item?.eventPrice == "0"
                                ? 'free'.tr()
                                : item?.eventPrice ?? '',
                            style: getSemiBoldStyle(
                                fontSize: 17.sp, color: AppColors.green),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.h),
                    if (item?.isMine == false)
                      if (isFollowed ?? false) ...[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                                child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 7.0.w),
                              child: CustomContainerButton(
                                title: isFollowed ?? false
                                    ? "cancel_this_event".tr()
                                    : "follow_event".tr(),
                                onTap: onTap,
                                borderColor: isFollowed ?? false
                                    ? AppColors.red
                                    : AppColors.white,
                                textColor: isFollowed ?? false
                                    ? AppColors.red
                                    : AppColors.white,
                              ),
                            )),
                            SizedBox(width: getWidthSize(context) / 50),
                          ],
                        ),
                      ] else ...[
                        CustomContainerButton(
                          title: isFollowed ?? false
                              ? "cancel_this_event".tr()
                              : "follow_event".tr(),
                          onTap: onTap,
                          borderColor: isFollowed ?? false
                              ? AppColors.red
                              : AppColors.white,
                          textColor: isFollowed ?? false
                              ? AppColors.red
                              : AppColors.white,
                        ),
                      ]
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
