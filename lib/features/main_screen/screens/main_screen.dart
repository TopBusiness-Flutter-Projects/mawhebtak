// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
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
  @override
  //
  Widget build(BuildContext context) {
    MainCubit cubit = context.read<MainCubit>();
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            if (cubit.currentpage == 0) {
              //  return await showExitDialog(context);
            } else {
              await cubit.changePage(0);
            }
            return false;
          },
          child: Scaffold(
            body: Stack(
              children: [
                // BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
                //   return CheckInternetWidget(
                //     whenResumed: () {
                //       // context.read<HomeCubit>().getHomeData();
                //       // context.read<AccountCubit>().getUserData();
                //     },
                //     child:
                //     // state is ErrorGetHomeData &&
                //     //         context.read<HomeCubit>().homeModel.data == null
                //     //     ? CustomErrorWidget(
                //     //         onTap: () {
                //     //           context.read<HomeCubit>().getHomeData();
                //     //         },
                //     //       )
                //     //     :
                //
                //   );
                // }
                //  ),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  cubit.changePage(0);
                                },
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    SvgPicture.asset(
                                      AppIcons.homeIcon,
                                      width: getHeightSize(context) * 0.03,
                                      color: cubit.currentpage == 0
                                          ? AppColors.primary
                                          : AppColors.grayLight,
                                    ),
                                    SizedBox(
                                        height: getHeightSize(context) * 0.008),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text("home".tr(),
                                          style: getRegularStyle(
                                              color: cubit.currentpage == 0
                                                  ? AppColors.primary
                                                  : AppColors.grayLight,
                                              fontSize: 13.sp)),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  cubit.changePage(1);
                                },
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    SvgPicture.asset(
                                      AppIcons.feeds,
                                      width: getHeightSize(context) * 0.03,
                                      color: cubit.currentpage == 1
                                          ? AppColors.primary
                                          : AppColors.grayLight,
                                    ),
                                    SizedBox(
                                        height: getHeightSize(context) * 0.008),
                                    Text("feeds".tr(),
                                        style: getRegularStyle(
                                            color: cubit.currentpage == 1
                                                ? AppColors.primary
                                                : AppColors.grayLight,
                                            fontSize: 13.sp)),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  cubit.changePage(2);
                                },
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    SvgPicture.asset(
                                      AppIcons.casting,
                                      width: getHeightSize(context) * 0.03,
                                      color: cubit.currentpage == 2
                                          ? AppColors.primary
                                          : AppColors.grayLight,
                                    ),
                                    SizedBox(
                                        height: getHeightSize(context) * 0.008),
                                    Text("casting".tr(),
                                        style: getRegularStyle(
                                            color: cubit.currentpage == 2
                                                ? AppColors.primary
                                                : AppColors.grayLight,
                                            fontSize: 13.sp)),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  cubit.changePage(3);
                                },
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    SvgPicture.asset(
                                      AppIcons.calendar,
                                      width: getHeightSize(context) * 0.03,
                                      color: cubit.currentpage == 3
                                          ? AppColors.primary
                                          : AppColors.grayLight,
                                    ),
                                    SizedBox(
                                        height: getHeightSize(context) * 0.008),
                                    Text("calendar".tr(),
                                        style: getRegularStyle(
                                            color: cubit.currentpage == 3
                                                ? AppColors.primary
                                                : AppColors.grayLight,
                                            fontSize: 13.sp)),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  cubit.changePage(4);
                                },
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    SvgPicture.asset(
                                      AppIcons.more,
                                      width: getHeightSize(context) * 0.03,
                                      color: cubit.currentpage == 4
                                          ? AppColors.primary
                                          : AppColors.grayLight,
                                    ),
                                    SizedBox(
                                        height: getHeightSize(context) * 0.008),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text("more".tr(),
                                          style: getRegularStyle(
                                              color: cubit.currentpage == 4
                                                  ? AppColors.primary
                                                  : AppColors.grayLight,
                                              fontSize: 13.sp)),
                                    ),
                                  ],
                                ),
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
