import 'package:lottie/lottie.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/widgets/my_svg_widget.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/events/screens/widgets/custom_apply_app_bar.dart';
import 'package:mawhebtak/features/my_advertiment/cubit/cubit.dart';
import 'package:mawhebtak/features/my_advertiment/cubit/state.dart';
import 'package:mawhebtak/features/packages/screens/widget/custom_container_package.dart';
import '../../../core/exports.dart';

class SubscribtionScreen extends StatefulWidget {
  const SubscribtionScreen({super.key});

  @override
  State<SubscribtionScreen> createState() => _SubscribtionScreenState();
}

class _SubscribtionScreenState extends State<SubscribtionScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MyAdvertismentCubit>().getUserPackageData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MyAdvertismentCubit, MyAdvertismentState>(
          builder: (context, state) {
            var cubit = context.read<MyAdvertismentCubit>();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBarWithClearWidget(
                  title: 'subscribtion'.tr(),
                ),
                SizedBox(height: 40.h),
                if (state is LoadingLawyerAdPackagesState)
                  const Center(child: CustomLoadingIndicator())
                else if ((cubit.userPackageModel?.data?.isEmpty ?? true))
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset(
                            'assets/animation_icons/search_no_data.json',
                            height: 200,
                            width: 200
                        ),
                        Center(child: Text("no_subscribtion".tr())),
                      ],
                    ),
                  )
                else
                  Flexible(
                    child: ListView.builder(
                      itemCount: cubit.userPackageModel?.data?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = cubit.userPackageModel!.data![index];
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.myAdvertismentRoute,
                              arguments: item.id.toString(),
                            );
                          },
                          child: ContainerOfPackage(
                            height: 125.h,
                            widgetOne: Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MySvgWidget(
                                        path: AppIcons.calendarIcon,
                                        imageColor: AppColors.primary,
                                        size: 20.w,
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(
                                          start: 8.0.w,
                                          bottom: 12.h,
                                        ),
                                        child: Text(
                                          '${"from_date".tr()} ${item.startDate?.toString().substring(0, 10) ?? ""}',
                                          style: TextStyle(
                                            fontFamily: AppStrings.fontFamily,
                                            color: AppColors.grayDark,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Flexible(
                                    child: Text(
                                      "monthly_package".tr(),
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontFamily: AppStrings.fontFamily,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${item.numberOfBumps ?? 0} ${"ads_per_month".tr()}',
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontFamily: AppStrings.fontFamily,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                      color: AppColors.grayDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            widgetTwo: Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MySvgWidget(
                                        path: AppIcons.calendarIcon,
                                        imageColor: AppColors.primary,
                                        size: 20.w,
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(
                                          start: 8.0.w,
                                          bottom: 12.h,
                                        ),
                                        child: Text(
                                          '${"to_date".tr()} ${item.endDate.toString().substring(0, 10) ?? ""}',
                                          style: TextStyle(
                                            fontFamily: AppStrings.fontFamily,
                                            color: AppColors.grayDark,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Flexible(
                                    child: Text(
                                      'reset_advertisment'.tr(),
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontFamily: AppStrings.fontFamily,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${item.numberOfBumps ?? 0} ${"ads".tr()}',
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontFamily: AppStrings.fontFamily,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                      color: AppColors.grayDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
