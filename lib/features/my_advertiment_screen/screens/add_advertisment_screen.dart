import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/events/screens/widgets/custom_apply_app_bar.dart';
import 'package:mawhebtak/features/my_advertiment_screen/cubit/cubit.dart';
import 'package:mawhebtak/features/my_advertiment_screen/cubit/state.dart';
import '../../../../core/widgets/date_widget.dart';
import '../../../core/exports.dart';

class AddAdvertismentScreen extends StatelessWidget {
  const AddAdvertismentScreen({super.key, });
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<MyAdvertismentCubit>();
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<MyAdvertismentCubit, MyAdvertismentState>(
            builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBarWithClearWidget(
                title: 'add_advertisment'.tr(),
              ),
              DatePickerField(
                title: "start_date".tr(),
                onTab: () {
                  cubit.onSelectedDate(context, isFromDate: true);
                },
                selectedDate: cubit.fromData,
              ),
              DatePickerField(
                title: "end_date".tr(),
                onTab: () {
                  cubit.onSelectedDate(context, isFromDate: false);
                },
                selectedDate: cubit.toDate,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.h),
                child: Text(
                  "advertisment_image".tr(),
                  style: getRegularStyle(
                    color: AppColors.black,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state is FilePickedSuccessfully) // استخدم الحالة
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.file(
                              cubit.uploadedImage ?? File(''),
                              width: 70.w,
                              height: 70.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 5.h,
                            right: 5.w,
                            child: GestureDetector(
                              onTap: () {
                                cubit.clearImage();
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 12.r,
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 14.sp * textScaleFactor(context),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      GestureDetector(
                        onTap: () {
                          cubit.pickImage(context, true);
                        },
                        child: DottedBorder(
                          color: Colors.black.withOpacity(0.2),
                          strokeWidth: 1,
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(8),
                          dashPattern: const [12, 4],
                          child: SizedBox(
                            height: 70.h,
                            width: 70.w,
                            child: Center(
                              child: Icon(
                                Icons.add,
                                size: 20.sp * textScaleFactor(context),
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 20.0, right: 10.w, bottom: 10.h, left: 10.w),
                child: state is LoadingAddAdsToLawyerPackageState
                    ? Center(
                        child: CustomLoadingIndicator(),
                      )
                    : CustomButton(
                        title: "send".tr(),
                        onTap: () {
                          //  cubit.addAdsToLawyerPackage(context, id: id.toString());
                        },
                      ),
              )
            ],
          );
        }),
      ),
    );
  }
}
