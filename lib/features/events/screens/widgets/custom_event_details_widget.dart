import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/exports.dart';
import '../../../home/screens/widgets/follow_button.dart';
import '../../data/model/event_details_model.dart';
import 'custom_media_view.dart';

class CustomEventDetailsWidget extends StatelessWidget {
  const CustomEventDetailsWidget({
    super.key,
    this.onTap,
    this.isFollowed,
    this.isDeepLink,
    required this.mediaList,
    required this.item,
  });

  final void Function()? onTap;
  final bool? isFollowed;
  final List<Media> mediaList;
  final bool? isDeepLink;
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
              bottomRight: Radius.circular(8.r),
            ),
            child: SizedBox(
              height: 220.h,
              width: getWidthSize(context),
              child:
              Image.asset(ImageAssets.logoImage, fit: BoxFit.cover),
            ),
          )
              : MediaCarousel(mediaList: mediaList),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 120.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.99),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),

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
              width: getWidthSize(context) / .9,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                SvgPicture.asset(AppIcons.calenderIcon),
                                SizedBox(width: 5.w),
                                Expanded(
                                  child: Text(
                                    item?.from ?? '',
                                    style: getRegularStyle(
                                      isShadow: true,
                                      fontSize: 14.sp,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (item?.eventPrice == "0") ...[
                                  Flexible(
                                    child: AutoSizeText(
                                      'free'.tr(),
                                      style: getSemiBoldStyle(
                                        fontSize: 17.sp,
                                        color: AppColors.green,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ] else if ((item?.discount != null &&
                                    item?.discount != "0") &&
                                    item?.priceAfterDiscount != null &&
                                    item?.priceAfterDiscount != item?.eventPrice) ...[
                                  Flexible(
                                    child: AutoSizeText(
                                      '${item?.eventPrice}',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.white,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: AppColors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Flexible(
                                    child: AutoSizeText(
                                      '${item?.priceAfterDiscount}',
                                      style: getSemiBoldStyle(
                                        fontSize: 17.sp,
                                        color: AppColors.green,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ] else ...[
                                  Flexible(
                                    child: AutoSizeText(
                                      '${item?.eventPrice}',
                                      style: getSemiBoldStyle(
                                        fontSize: 17.sp,
                                        color: AppColors.green,
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
                    ),
                    SizedBox(height: 5.h),

                    // ✅ زر المتابعة / الإلغاء
                    if (item?.isMine == false)
                      if (isFollowed ?? false) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 7.0.w),
                                child: CustomContainerButton(
                                  title: "cancel_this_event".tr(),
                                  onTap: onTap,
                                  borderColor: AppColors.red,
                                  textColor: AppColors.red,
                                ),
                              ),
                            ),
                            SizedBox(width: getWidthSize(context) / 50),
                          ],
                        ),
                      ] else ...[
                        CustomContainerButton(
                          title: "follow_event".tr(),
                          onTap: onTap,
                          borderColor: AppColors.white,
                          textColor: AppColors.white,
                        ),
                      ],
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
