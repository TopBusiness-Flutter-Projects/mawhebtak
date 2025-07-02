import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/widgets/my_svg_widget.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/events/screens/widgets/custom_apply_app_bar.dart';
import 'package:mawhebtak/features/packages/screens/widget/custom_container_package.dart';
import '../../../core/exports.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class MyAdvertismentScreen extends StatefulWidget {
  const MyAdvertismentScreen({super.key, required this.idFromPackage});
  final String idFromPackage;

  @override
  State<MyAdvertismentScreen> createState() => _MyAdvertismentScreenState();
}

class _MyAdvertismentScreenState extends State<MyAdvertismentScreen> {
  @override
  initState() {
    super.initState();
    context.read<MyAdvertismentCubit>().getUserPackageDetailsData(idFromPackage: widget.idFromPackage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.addAdvertismentRoute,
            arguments: widget.idFromPackage,
          );
        },
        child: Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(90),
          ),
          child: Center(
            child: Text(
              "+",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<MyAdvertismentCubit, MyAdvertismentState>(
            builder: (context, state) {
              var cubit = context.read<MyAdvertismentCubit>();
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBarWithClearWidget(
                    title: "apply_for_event".tr(),
                  ),
                  SizedBox(height: 40.h),
                  (state is LoadingLawyerPackageAdsState)
                      ? const Center(child: CustomLoadingIndicator())
                      : Expanded(
                    child: Column(
                      children: [
                        ContainerOfPackage(
                          height: 125.h,
                          widgetOne: Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                        '${"from_date".tr()} ${cubit.userPackageDetailsModel?.data?.package?.fromDate.toString() ?? ""}',
                                        maxLines: 1,
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
                                    'monthly_package'.tr(),
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontFamily: AppStrings.fontFamily,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${cubit.userPackageDetailsModel?.data?.package?.numberOfAds ?? 0} ${"ads_per_month".tr()}',
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                        '${"to_date".tr()} ${cubit.userPackageDetailsModel?.data?.package?.toDate.toString()}',
                                        maxLines: 1,
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
                                  '${cubit.userPackageDetailsModel?.data?.package?.numberOfBumps ?? 0} ${"ads".tr()}',
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
                        Expanded(
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cubit.userPackageDetailsModel?.data?.ads?.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  cubit.userPackageDetailsModel?.data?.ads?[index].image == null
                                      ? Image.asset(
                                    "assets/images/app_icon_white.png",
                                    height: 120.h,
                                    width: double.infinity,
                                  )
                                      : Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                    child: Image.network(
                                      cubit.userPackageDetailsModel?.data?.ads?[index].image.toString() ?? "",
                                      height: 120.h,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.date_range, size: 15.sp, color: AppColors.primary),
                                            SizedBox(width: 10.w),
                                            Text(
                                              '${"expiration_date".tr()} ${cubit.userPackageDetailsModel?.data?.ads?[index].toDate.toString().substring(0, 10)}',
                                              style: TextStyle(
                                                color: AppColors.gray,
                                                fontSize: 13.sp,
                                                fontFamily: AppStrings.fontFamily,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.yellow,
                                            borderRadius: BorderRadius.circular(5.sp),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                                            child: Center(
                                              child: Text(
                                                cubit.userPackageDetailsModel?.data?.ads?[index].status ?? "",
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
