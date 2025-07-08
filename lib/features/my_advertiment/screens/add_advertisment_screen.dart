import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/core/widgets/dropdown_button_form_field.dart';
import 'package:mawhebtak/features/announcement/cubit/announcement_cubit.dart';
import 'package:mawhebtak/features/casting/cubit/casting_cubit.dart';
import 'package:mawhebtak/features/events/cubit/event_cubit.dart';
import 'package:mawhebtak/features/events/screens/widgets/custom_apply_app_bar.dart';
import 'package:mawhebtak/features/home/cubits/top_events_cubit/top_events_cubit.dart';
import 'package:mawhebtak/features/my_advertiment/cubit/cubit.dart';
import 'package:mawhebtak/features/my_advertiment/cubit/state.dart';
import '../../../../core/widgets/date_widget.dart';
import '../../../core/exports.dart';

class AddAdvertismentScreen extends StatelessWidget {
  const AddAdvertismentScreen({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<MyAdvertismentCubit>();
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MyAdvertismentCubit, MyAdvertismentState>(
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
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.h),
                child: Text(
                  "model_type".tr(),
                  style: getRegularStyle(
                    color: AppColors.black,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              GeneralCustomDropdownButtonFormField<String>(
                value: cubit.selectedModelType,
                onChanged: (value) {
                  cubit.selectedModelType = value;
                  cubit.selectedModelTypeId = null;

                  if (value == "Event") {
                    cubit.getEventsData();
                  } else if (value == "Gig") {
                    cubit.getGigsData();
                  } else if (value == "Announcement") {
                    cubit.getAnnouncementData();
                  }
                },
                items: cubit.modelTypeMap.entries.map((e) => e.key).toList(),
                itemBuilder: (item) => cubit.modelTypeMap[item] ?? '',
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.h),
                child: Text(
                  "types".tr(),
                  style: getRegularStyle(
                    color: AppColors.black,
                    fontSize: 16.sp,
                  ),
                ),
              ),

           
              cubit.selectedList.isEmpty
                  ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Text(
                  "no_data_available".tr(),
                  style: getRegularStyle(
                    color: AppColors.grey,
                    fontSize: 14.sp,
                  ),
                ),
              )
                  :
              GeneralCustomDropdownButtonFormField<String>(
                value: cubit.selectedModelTypeId,
                onChanged: (value) {
                  cubit.selectedModelTypeId = value;
                },
                items: cubit.selectedList.map((e) => e.id).toList(),
                itemBuilder: (id) => cubit.selectedList.firstWhere((e) => e.id == id).name,
              ),


              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.h),
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
                    (cubit.uploadedImage != null)
                        ? Stack(
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
                        : GestureDetector(
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
                child: CustomButton(
                  title: "send".tr(),
                  onTap: () {
                    if (cubit.fromData.isAfter(cubit.toDate)) {
                      Fluttertoast.showToast(
                          msg: "start_date_must_be_before_end_date".tr());
                      return;
                    }
                    cubit.addAdds(context, id: id.toString());
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
