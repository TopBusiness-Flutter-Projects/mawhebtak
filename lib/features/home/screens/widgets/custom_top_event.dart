import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/features/casting/data/model/request_gigs_model.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/exports.dart';
import '../../../events/screens/details_event_screen.dart';
import 'follow_button.dart';

class CustomTopEventList extends StatelessWidget {
  const CustomTopEventList(
      {super.key,
      this.isLeftPadding,
      this.isRightPadding,
      this.isAll,
      required this.topEvent});
  final bool? isLeftPadding;
  final bool? isRightPadding;
  final bool? isAll;
  final EventAndGigsModel? topEvent;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          start: isLeftPadding ?? false ? 16.w : 8.w,
          end: isRightPadding ?? false ? 16.w : 0.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          topEvent?.image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: SizedBox(
                    height: 200.h,
                    width: isAll ?? false ? getWidthSize(context) / .9 : 287.w,
                    child: Image.network(topEvent?.image ?? "",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                              ImageAssets.imagePicked,
                              fit: BoxFit.contain,
                            )),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: SizedBox(
                    height: 200.h,
                    width: isAll ?? false ? getWidthSize(context) / .9 : 287.w,
                    child: Image.asset(
                      ImageAssets.imagePicked,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: isAll ?? false
                    ? getWidthSize(context) / .9
                    : 287.w, // Match image width
                child: Padding(
                  padding: EdgeInsets.all(8.0.r),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.end, // Center vertically
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Center horizontally
                    children: [
                      Text(
                        topEvent?.title ?? "",
                        maxLines: 1,
                        style: getBoldStyle(
                          color: AppColors.white,
                          fontSize: 16.sp,
                          isShadow: true,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        topEvent?.description ?? "",
                        maxLines: 1,
                        style: getRegularStyle(
                            isShadow: true,
                            color: AppColors.grayText,
                            fontSize: 14.sp),
                        textAlign: TextAlign.left,
                      ),
                      5.h.verticalSpace,
                      Row(
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
                                    topEvent?.from ?? "",
                                    style: getRegularStyle(
                                        fontSize: 14.sp,
                                        isShadow: true,
                                        color: AppColors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomContainerButton(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.detailsEventRoute,
                                  arguments: DeepLinkDataModel(
                                      id: topEvent?.id.toString() ?? '',
                                      isDeepLink: false));
                            },
                            title: "details".tr(),
                            color: AppColors.transparent,
                            textColor: isAll ?? false
                                ? AppColors.lbny
                                : AppColors.primary,
                            borderColor: isAll ?? false
                                ? AppColors.lbny
                                : AppColors.primary,
                            width: 120.w,
                          ),
                        ],
                      ),
                      5.h.verticalSpace,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
