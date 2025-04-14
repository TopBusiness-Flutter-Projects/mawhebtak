// ignore_for_file: deprecated_member_use

import 'package:travel_club/core/exports.dart';
import 'package:travel_club/features/home/cubit/home_cubit.dart';
import 'package:travel_club/features/home/cubit/home_state.dart';
import 'package:travel_club/features/main_screen/cubit/cubit.dart';
import 'package:travel_club/features/main_screen/cubit/state.dart';
import 'package:travel_club/features/my_account/cubit/account_cubit.dart';

import 'check_internet_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.index});
  final int? index;
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
              return await showExitDialog(context);
            } else {
              await cubit.changePage(0);
            }
            return false;
          },
          child: Scaffold(
            body: Stack(
              children: [
                BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
                  return CheckInternetWidget(
                    whenResumed: () {
                      context.read<HomeCubit>().getHomeData();
                      context.read<AccountCubit>().getUserData();
                    },
                    child: state is ErrorGetHomeData &&
                            context.read<HomeCubit>().homeModel.data == null
                        ? CustomErrorWidget(
                            onTap: () {
                              context.read<HomeCubit>().getHomeData();
                            },
                          )
                        : cubit.screens[cubit.currentpage],
                  );
                }),
                Positioned(
                    bottom: 0,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  cubit.changePage(0);
                                },
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.home,
                                      width: getHeightSize(context) * 0.04,
                                      color: cubit.currentpage == 0
                                          ? AppColors.primary
                                          : AppColors.grey,
                                    ),
                                    SizedBox(
                                        height: getHeightSize(context) * 0.008),
                                    Text(AppTranslations.home,
                                        style: getSemiBoldStyle(
                                            color: cubit.currentpage == 0
                                                ? AppColors.primary
                                                : AppColors.grey,
                                            fontSize: 12.sp)),
                                    if (cubit.currentpage == 0)
                                      SvgPicture.asset(
                                        AppIcons.choosenNav,
                                        width: 40.w,
                                      )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  cubit.changePage(1);
                                },
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.myBookings,
                                      width: getHeightSize(context) * 0.04,
                                      color: cubit.currentpage == 1
                                          ? AppColors.primary
                                          : AppColors.grey,
                                    ),
                                    SizedBox(
                                        height: getHeightSize(context) * 0.008),
                                    Text(AppTranslations.myBookings,
                                        style: getSemiBoldStyle(
                                            color: cubit.currentpage == 1
                                                ? AppColors.primary
                                                : AppColors.grey,
                                            fontSize: 12.sp)),
                                    if (cubit.currentpage == 1)
                                      SvgPicture.asset(
                                        AppIcons.choosenNav,
                                        width: 40.w,
                                      )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  cubit.changePage(2);
                                },
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.favourites,
                                      width: getHeightSize(context) * 0.04,
                                      color: cubit.currentpage == 2
                                          ? AppColors.primary
                                          : AppColors.grey,
                                    ),
                                    SizedBox(
                                        height: getHeightSize(context) * 0.008),
                                    Text(AppTranslations.favorites,
                                        style: getSemiBoldStyle(
                                            color: cubit.currentpage == 2
                                                ? AppColors.primary
                                                : AppColors.grey,
                                            fontSize: 12.sp)),
                                    if (cubit.currentpage == 2)
                                      SvgPicture.asset(
                                        AppIcons.choosenNav,
                                        width: 40.w,
                                      )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  cubit.changePage(3);
                                },
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.myAccount,
                                      width: getHeightSize(context) * 0.04,
                                      color: cubit.currentpage == 3
                                          ? AppColors.primary
                                          : AppColors.grey,
                                    ),
                                    SizedBox(
                                        height: getHeightSize(context) * 0.008),
                                    Text(AppTranslations.myAccount,
                                        style: getSemiBoldStyle(
                                            color: cubit.currentpage == 3
                                                ? AppColors.primary
                                                : AppColors.grey,
                                            fontSize: 12.sp)),
                                    if (cubit.currentpage == 3)
                                      SvgPicture.asset(
                                        AppIcons.choosenNav,
                                        width: 40.w,
                                      )
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
