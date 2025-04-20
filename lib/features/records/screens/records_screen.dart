import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/widgets/custom_simple_appbar.dart';
import 'package:mawhebtak/features/records/cubit/records_cubit.dart';
import 'package:mawhebtak/features/records/cubit/records_state.dart';

import '../../../core/exports.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  @override


  Widget build(BuildContext context) {
    var cubit = context.read<RecordsCubit>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent, // الشفافية
        statusBarIconBrightness: Brightness.light, // لون الأيقونات (أبيض)
      ),
      child: Scaffold(
        body: Stack(
          children: [

            Column(
              children: [
                10.h.verticalSpace,
                CustomSimpleAppbar(title: "records".tr()),
                BlocBuilder<RecordsCubit,RecordsState>(
                  builder: (context,state) {
                    return Expanded(
                      child: Container(
                        decoration: BoxDecoration(color: AppColors.grayLite),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(top:20.w,left:20.w, right:20.w),
                              child: Text("my_work".tr(),style: getMediumStyle(fontSize: 14.sp),),
                            ),

                            Expanded(
                              child: ListView.builder(

                                  shrinkWrap: true,
                                  itemCount: 5,
                                  itemBuilder: (context, index) =>
                                  GestureDetector(
                                onTap: () {

                                },
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 10.h,
                                        left: 20.w,
                                        right: 20.w,
                                        top: 10.h,
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(AppIcons.bagIcon),
                                          10.w.horizontalSpace,
                                          Expanded(
                                            child: Column(

                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [

                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [

                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              "Al gezera 2 Series",
                                                              style: getMediumStyle(fontSize: 14.sp),
                                                            ),
                                                            10.h.verticalSpace,
                                                            Text(
                                                              "10 Racors",
                                                              style: getMediumStyle(
                                                                  fontSize: 13.sp,
                                                                  color: AppColors.secondPrimary),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Icon(Icons.arrow_forward_ios,
                                                      size: 20.sp,
                                                      color: AppColors.darkGray.withOpacity(0.5),
                                                    ),
                                                  ],
                                                ),


                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ) ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                )
              ],
            ),
            Positioned(
              bottom: 50.h,
              right: 20.w,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.addNewRecordRoute);
                },
                child: Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
