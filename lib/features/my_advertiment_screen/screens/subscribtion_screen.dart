import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/widgets/my_svg_widget.dart';
import 'package:mawhebtak/features/events/screens/widgets/custom_apply_app_bar.dart';
import 'package:mawhebtak/features/my_advertiment_screen/cubit/cubit.dart';
import 'package:mawhebtak/features/my_advertiment_screen/cubit/state.dart';
import 'package:mawhebtak/features/packages/screens/widget/custom_container_package.dart';
import '../../../core/exports.dart';

class SubscribtionScreen extends StatefulWidget {
  const SubscribtionScreen({super.key});

  @override
  State<SubscribtionScreen> createState() => _SubscribtionScreenState();
}

class _SubscribtionScreenState extends State<SubscribtionScreen> {
  @override
  initState() {
    super.initState();
  //  context.read<MyAdvertismentCubit>().getLawyerAdPackages();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyAdvertismentCubit, MyAdvertismentState>(
          builder: (context, state) {
        var cubit = context.read<MyAdvertismentCubit>();
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBarWithClearWidget(
              title:  'subscribtion'.tr(),
            ),
            SizedBox(
              height: 40.h,
            ),
            // (state is LoadingLawyerAdPackagesState)?
            //     const Center(child: CustomLoadingIndicator(),):
            // (cubit.getLawyerAdPackagesModel?.data?.length == 0)?
            //     Center(child: Text("no_subscribtion".tr()),):
            Flexible(
              child: ListView.builder(
                //itemCount: cubit.getLawyerAdPackagesModel?.data?.length ?? 0,
                itemCount: 1,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.myAdvertismentRoute,
                      //    arguments: cubit.getLawyerAdPackagesModel?.data?[index].packageId.toString()

                      );
                    },
                    child:  ContainerOfPackage(
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
                                    size: 20.w),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    start: 8.0.w,
                                    bottom: 12.h,
                                  ),
                                  child: Text(
                                    //'من : ${cubit.getLawyerAdPackagesModel?.data?[index].startDate}',
                                    'من 12:12',
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
                              ' 2 اعلانات فى الشهر',
                             // '${cubit.getLawyerAdPackagesModel?.data?[index].numberOfAds??0} اعلانات فى الشهر ',
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
                                    size: 20.w),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    start: 8.0.w,
                                    bottom: 12.h,
                                  ),
                                  child: Text(
                                    'الي 5',
                                 //   '   الي : ${cubit.getLawyerAdPackagesModel?.data?[index].endDate}',
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
                              'اعلانات 5',
                            //  "${cubit.getLawyerAdPackagesModel?.data?[index].numberOfBumps??0} اعلانات",
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
                    )
                  );
                },
              ),
            )
          ],
        );
      }),
    );
  }
}
