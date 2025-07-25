import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_app_bar_row.dart';
import 'package:mawhebtak/features/more/cubit/more_state.dart';
import '../../../core/exports.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/utils/check_login.dart';
import '../../events/screens/details_event_screen.dart';
import '../cubit/more_cubit.dart';
import 'widget/custom_logout_dialog.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  void initState() {
    context.read<MoreCubit>().loadUserFromPreferences();
    super.initState();
  }

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
                  BlocBuilder<MoreCubit,MoreState>(
                    builder: (context,state) {
                      var cubit  = context.read<MoreCubit>();
                      return Expanded(
                        child:  ListView(
                          children: [
                            if(cubit.user?.data?.token != null)
                              moreContainer(
                                text: "my_profile".tr(),
                                imageUrl: AppIcons.myProfileIcon,
                                onTap: () async {
                                  final user =
                                      await Preferences.instance.getUserModel();
                                  if (user.data?.token == null) {
                                    checkLogin(context);
                                  } else {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.profileRoute,
                                      arguments: DeepLinkDataModel(
                                          id: context
                                                  .read<MoreCubit>()
                                                  .user
                                                  ?.data
                                                  ?.id
                                                  ?.toString() ??
                                              "",
                                          isDeepLink: false),
                                    );
                                  }
                                }),
                            if(cubit.user?.data?.token != null)

                              moreContainer(
                                text: "my_favorites".tr(),
                                imageUrl: AppIcons.myFavoriteIcon,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.favouritesRoute);
                                }),


                            moreContainer(
                                text: "future_app".tr(),
                                imageUrl: AppIcons.myFavoriteIcon,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.futureAppRoute);
                                }),
                            if(cubit.user?.data?.token != null)
                              moreContainer(
                                text: "my_event".tr(),
                                imageUrl: AppIcons.eventIcon,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.myEventsRoute);
                                }),

                            if(cubit.user?.data?.token != null)

                              moreContainer(
                                text: "chats".tr(),
                                imageUrl: AppIcons.chatIcon,
                                onTap: () async {
                                  final user =
                                      await Preferences.instance.getUserModel();
                                  if (user.data?.token == null) {
                                    checkLogin(context);
                                  } else {
                                    Navigator.pushNamed(
                                        context, Routes.roomsScreen);
                                  }
                                }),
                            if(cubit.user?.data?.token != null)
                            moreContainer(
                                text: "wallet".tr(),
                                imageUrl: AppIcons.walletIcon,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.electronicWalletRoute);
                                }),
                            if(cubit.user?.data?.token != null)

                              moreContainer(
                                text: "referral_code".tr(),
                                imageUrl: AppIcons.referralCode,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.referralCodeRoute);
                                }),
                            if(cubit.user?.data?.token != null)
                            moreContainer(
                                text: "change_language".tr(),
                                imageUrl: AppIcons.changeLanguage,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.changeLanguageRoute,arguments: false);
                                }),
                            if(cubit.user?.data?.token != null)

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
                            if(cubit.user?.data?.token != null)
                            moreContainer(
                                text: 'packages'.tr(),
                                imageUrl: AppIcons.packageIcon,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.packagesRoute);
                                }),

                            moreContainer(
                                text: 'subscribtion'.tr(),
                                imageUrl: AppIcons.subscribtionIcon,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.subscribtionRoute);
                                }),
                            if(cubit.user?.data?.token != null)
                            moreContainer(
                                text: "complaining".tr(),
                                imageUrl: AppIcons.complaingIcon,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.contactUsRoute,
                                      arguments: "complaints");
                                }),
                            moreContainer(
                                text: "terms_and_condition".tr(),
                                imageUrl: AppIcons.termsAndCondition,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, Routes.termsAndConditionRoute);
                                }),
                            if(cubit.user?.data?.token != null)
                              moreContainer(
                              text: "delete_account".tr(),
                              imageUrl: AppIcons.deleteAccountIcon,
                              onTap: () {
                                showAnimatedDeleteDialog(context, () {
                                  context
                                      .read<MoreCubit>()
                                      .deleteAccount(context: context);
                                });
                              },
                            ),

                            if(cubit.user?.data?.token != null)
                            moreContainer(
                              text: "logout".tr(),
                              imageUrl: AppIcons.logout,
                              onTap: () {
                                showAnimatedLogoutDialog(context, () {
                                  context
                                      .read<MoreCubit>()
                                      .logout(context: context);
                                  Preferences.instance.clearShared();
                                });
                              },
                            ),
                            if(cubit.user?.data?.token == null)
                              moreContainer(
                                text: "login".tr(),
                                imageUrl:AppIcons.logout ,
                                onTap: () {
                                 Navigator.pushNamed(context, Routes.loginRoute);
                                },
                              ),
                              SizedBox(
                              height: 50.h,
                            ),
                          ],
                        ),
                      );
                    }
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

  void showAnimatedDeleteDialog(BuildContext context, VoidCallback onConfirm) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "delete_account",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return Transform.scale(
          scale: animation.value,
          child: Opacity(
            opacity: animation.value,
            child: CustomDeleteDialog(onConfirm: onConfirm),
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
