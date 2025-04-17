import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_app_bar_row.dart';
import 'package:mawhebtak/features/more_screen/screens/widget/custom_logout_dialog.dart';
import '../../../core/exports.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            20.h.verticalSpace,
            Padding(
              padding:  EdgeInsets.only(left: 10.w,right: 10.w),
              child: CustomAppBarRow(
                colorTextFromSearchTextField: AppColors.darkGray.withOpacity(0.3),
                backgroundColorTextFieldSearch: AppColors.grayLite,
                isMore:true,
                colorSearchIcon: AppColors.secondPrimary,
                backgroundNotification: AppColors.primary,
              ),
            ),
            5.h.verticalSpace,
            Expanded(child: Container(
              decoration: BoxDecoration(
                color:AppColors.grayLight.withOpacity(0.2),
              ),
              child: Padding(
                padding:  EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h,bottom: 10.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top: 10.h,bottom: 10.h),
                      child: Text("more".tr(),style: TextStyle(fontSize: 14.sp),),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          moreContainer(
                              text: "my_profile".tr(),
                              imageUrl: ImageAssets.myProfileIcon,
                              onTap: (){}
                          ),
                          moreContainer(
                              text: "my_favorites".tr(),
                              imageUrl: ImageAssets.myFavoriteIcon,
                              onTap: (){}
                          ),

                          moreContainer(
                              text: "wallet".tr(),
                              imageUrl: ImageAssets.walletIcon,
                              onTap: (){}
                          ),
                          moreContainer(
                              text: "referral_code".tr(),
                              imageUrl: ImageAssets.referralCode,
                              onTap: (){
                                Navigator.pushNamed(context, Routes.referralCodeRoute);
                              }
                          ),moreContainer(
                              text: "change_language".tr(),
                              imageUrl: ImageAssets.changeLanguage,
                              onTap: (){
                                Navigator.pushNamed(context, Routes.changeLanguageRoute);
                              }
                          ),
                          moreContainer(
                              text: "change_password".tr(),
                              imageUrl: ImageAssets.changePassword,
                              onTap: (){
                                Navigator.pushNamed(context, Routes.changePasswordRoute);
                              }
                          ),
                          moreContainer(
                              text: "about_us".tr(),
                              imageUrl: ImageAssets.aboutUs,
                              onTap: (){
                                Navigator.pushNamed(context, Routes.aboutUsRoute);
                              }
                          ),
                          moreContainer(
                              text: "contact_us".tr(),
                              imageUrl: ImageAssets.contactUs,
                              onTap: (){
                                Navigator.pushNamed(context, Routes.contactUsRoute);
                              }
                          ),
                          moreContainer(
                              text: "terms_and_condition".tr(),
                              imageUrl: ImageAssets.termsAndCondition,
                              onTap: (){
                                Navigator.pushNamed(context, Routes.termsAndConditionRoute);
                              }
                          ),
                          moreContainer(
                              text: "logout".tr(),
                              imageUrl: ImageAssets.logout,
                            onTap: () {
                              showAnimatedLogoutDialog(context, () {
                              Navigator.pushNamed(context, Routes.loginRoute);
                              });
                            },

                          ),
                          SizedBox(height: 40.h,),

                        ],
                      ),
                    )
                  ],
                ),
              ),

            ))
          ],
        ),
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
        padding:  EdgeInsets.only(bottom: 10.h),
        child: Container(

                        padding: EdgeInsets.only(left: 15.w, right: 15.w,bottom: 15.h,top: 15.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: AppColors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                               SvgPicture.asset(imageUrl),
                                10.w.horizontalSpace,
                                Text(text,style: TextStyle(fontSize: 14.sp,color: AppColors.black,fontWeight: FontWeight.w400),),
                              ],
                            ),

                            GestureDetector(
                              onTap: onTap,
                              child: Icon(
                                Icons.arrow_forward_ios_sharp,
                                color: AppColors.primary,
                                size: 20,),
                            ),
                          ],
                        ),
                      ),
      ),
    );
  }
}
