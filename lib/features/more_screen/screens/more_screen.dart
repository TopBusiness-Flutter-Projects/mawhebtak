import 'dart:developer';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_app_bar_row.dart';
import 'package:mawhebtak/features/main_screen/cubit/cubit.dart';
import 'package:mawhebtak/features/more_screen/screens/widget/custom_logout_dialog.dart';
import '../../../core/exports.dart';
import '../../../core/preferences/preferences.dart';
import '../../events/screens/details_event_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40.h),
            child: CustomAppBarRow(
              colorTextFromSearchTextField: AppColors.darkGray.withOpacity(0.3),
              backgroundColorTextFieldSearch: AppColors.grayLite,
              isMore: true,
              colorSearchIcon: AppColors.secondPrimary,
              backgroundNotification: AppColors.primary,
            ),
          ),
          5.h.verticalSpace,
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              color: AppColors.grayLight.withOpacity(0.2),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 10.w, right: 10.w, top: 10.h, bottom: 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                    child: Text(
                      "more".tr(),
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        moreContainer(
                            text: "my_profile".tr(),
                            imageUrl: AppIcons.myProfileIcon,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.profileScreen,
                                arguments: DeepLinkDataModel(
                                    id: context.read<MainCubit>().loginModel?.data?.id?.toString() ?? "",
                                    isDeepLink: false),
                              );
                            }),
                        moreContainer(
                            text: "my_favorites".tr(),
                            imageUrl: AppIcons.myFavoriteIcon,
                            onTap: () {}),
                        moreContainer(
                            text: "wallet".tr(),
                            imageUrl: AppIcons.walletIcon,
                            onTap: () {}),
                        moreContainer(
                            text: "referral_code".tr(),
                            imageUrl: AppIcons.referralCode,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.referralCodeRoute);
                            }),
                        moreContainer(
                            text: "change_language".tr(),
                            imageUrl: AppIcons.changeLanguage,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.changeLanguageRoute);
                            }),
                        moreContainer(
                            text: "change_password".tr(),
                            imageUrl: AppIcons.changePassword,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.changePasswordRoute);
                            }),
                        moreContainer(
                            text: "about_us".tr(),
                            imageUrl: AppIcons.aboutUs,
                            onTap: () {
                              Navigator.pushNamed(context, Routes.aboutUsRoute);
                            }),
                        moreContainer(
                            text: "advertising_and_publicity".tr(),
                            imageUrl: AppIcons.contactUs,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.contactUsRoute,
                                  arguments: "advertising_and_publicity");
                            }),
                        moreContainer(
                            text: "complaining".tr(),
                            imageUrl: AppIcons.contactUs,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.contactUsRoute,
                                  arguments: "complaining");
                            }),
                        moreContainer(
                            text: "terms_and_condition".tr(),
                            imageUrl: AppIcons.termsAndCondition,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.termsAndConditionRoute);
                            }),
                        moreContainer(
                          text: "logout".tr(),
                          imageUrl: AppIcons.logout,
                          onTap: () {
                            showAnimatedLogoutDialog(context, () {
                              Preferences.instance.clearShared();
                              Navigator.pushNamed(context, Routes.loginRoute);
                            });
                          },
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }

  void showAnimatedLogoutDialog(BuildContext context, VoidCallback onConfirm) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Logout",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return Transform.scale(
          scale: animation.value,
          child: Opacity(
            opacity: animation.value,
            child: CustomLogoutDialog(onConfirm: onConfirm),
          ),
        );
      },
    );
  }

  GestureDetector moreContainer({
    required String imageUrl,
    required String text,
    required void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Container(
          padding:
              EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h, top: 15.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r), color: AppColors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(imageUrl, height: 25.h),
                  10.w.horizontalSpace,
                  Text(
                    text,
                    style: TextStyle(
                        fontSize: 16.sp,
                        // color: AppColors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onTap,
                child: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: AppColors.primary,
                  size: 20.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
