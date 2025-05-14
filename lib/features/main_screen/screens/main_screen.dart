// ignore_for_file: deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/exports.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<bool> _showExitDialog(BuildContext context) async {
    bool exitConfirmed = false;
    await AwesomeDialog(
      context: context,
      animType: AnimType.bottomSlide,
      customHeader: Padding(
        padding: const EdgeInsets.all(20),
        child: Image.asset(
          ImageAssets.logoImage,
          width: 80,
          height: 80,
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "exit_app".tr(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            "exit_app_desc".tr(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      exitConfirmed = false;
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.redLight,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text("cancel".tr(),
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      exitConfirmed = true;
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text("out".tr(),
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).show();

    return exitConfirmed;
  }

  @override
  //
  Widget build(BuildContext context) {
    MainCubit cubit = context.read<MainCubit>();
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            if (cubit.currentpage == 0) {
              bool shouldExit = await _showExitDialog(context);
              if (shouldExit) {
                SystemNavigator.pop();
              }
              return shouldExit;
            } else {
              await cubit.changePage(0);
            }
            return false;
          },
          child: Scaffold(
            body: Stack(
              children: [
                cubit.screens[cubit.currentpage],
                Positioned(
                    bottom: 0,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomBottomNavBarItem(
                                cubit: cubit,
                                index: 0,
                                icon: AppIcons.homeIcon,
                                title: 'home'.tr(),
                              ),
                              CustomBottomNavBarItem(
                                cubit: cubit,
                                index: 1,
                                icon: AppIcons.feeds,
                                title: 'feeds'.tr(),
                              ),
                              CustomBottomNavBarItem(
                                cubit: cubit,
                                index: 2,
                                icon: AppIcons.casting,
                                title: 'casting'.tr(),
                              ),
                              CustomBottomNavBarItem(
                                cubit: cubit,
                                index: 3,
                                icon: AppIcons.calendar,
                                title: 'calendar'.tr(),
                              ),
                              CustomBottomNavBarItem(
                                cubit: cubit,
                                index: 4,
                                icon: AppIcons.more,
                                title: 'more'.tr(),
                              ),
                            ],
                          ),
                        )))
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomBottomNavBarItem extends StatelessWidget {
  const CustomBottomNavBarItem({
    super.key,
    required this.index,
    required this.cubit,
    required this.title,
    required this.icon,
  });

  final MainCubit cubit;
  final int index;
  final String title;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        cubit.changePage(index);
      },
      child: Column(
        children: [
          SvgPicture.asset(
            icon,
            width: getHeightSize(context) * 0.03,
            color: cubit.currentpage == index
                ? AppColors.primary
                : AppColors.grayLight,
          ),
          Text(title,
              style: getRegularStyle(
                  color: cubit.currentpage == index
                      ? AppColors.primary
                      : AppColors.grayLight,
                  fontSize: 13.sp)),
        ],
      ),
    );
  }
}
