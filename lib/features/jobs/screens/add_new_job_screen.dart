import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/features/calender/cubit/calender_cubit.dart';
import 'package:mawhebtak/features/calender/cubit/calender_state.dart';
import 'package:mawhebtak/features/calender/screens/widgets/price_range_fields.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/image_view_file.dart';
import 'package:mawhebtak/features/jobs/cubit/jobs_cubit.dart';
import 'package:mawhebtak/features/jobs/cubit/jobs_state.dart';
import 'package:mawhebtak/features/location/cubit/location_cubit.dart';
import 'package:mawhebtak/features/location/cubit/location_state.dart';
import 'package:mawhebtak/features/location/screens/full_screen_map.dart';

import '../../events/screens/widgets/custom_apply_app_bar.dart';

class AddNewJobScreen extends StatefulWidget {
  const AddNewJobScreen({super.key});

  @override
  State<AddNewJobScreen> createState() => _AddNewJobScreenState();
}

class _AddNewJobScreenState extends State<AddNewJobScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          10.h.verticalSpace,
          CustomAppBarWithClearWidget(title: "new_job".tr()),
          10.h.verticalSpace,
          Expanded(
            child: SingleChildScrollView(
              child: BlocBuilder<JobsCubit,JobsState>(
                builder: (context,state) {
                  var cubit = context.read<JobsCubit>();
                  return Padding(
                    padding:  EdgeInsets.only(left: 20.w,right: 20.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label("needed_talent".tr()),
                         CustomTextField(
                          controller:cubit.jopUserTitleController,
                          hintText: "John doe",
                        ),
                         PriceRangeFields(jobsCubit: cubit,),
                        _label("select_location".tr()),
                        BlocBuilder<LocationCubit, LocationState>(
                          builder: (context, state) {
                            return CustomTextField(
                              hintTextSize: 18.sp,
                              controller: cubit.locationController,
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return 'select_location'.tr();
                                }
                                return null;
                              },
                              hintText: "select_location".tr(),
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FullScreenMap(
                                        type: 'add_gig',
                                      )));
                            },
                            child: Text(
                              "open_map".tr(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        _label("to".tr()),
                        CustomTextField(
                          controller: cubit.eventDateController,
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(10.0.r),
                            child: SvgPicture.asset(AppIcons.dateIcon),
                          ),
                          onTap: () {
                            cubit.selectDateTime(context);
                          },
                          hintTextSize: 14.sp,
                          hintText: "",
                        ),
                        _label("description".tr()),
                        CustomTextField(
                          controller: cubit.descriptionController,
                          isMessage: true,
                        ),

                        Text(
                          "image_or_video".tr(),
                          style: getRegularStyle(fontSize: 14.sp),
                        ),
                        10.verticalSpace,
                        InkWell(
                            onTap: () {
                              context
                                  .read<CalenderCubit>()
                                  .showSelectionBottomSheet(context);
                            },
                            child: Image.asset(
                              ImageAssets.imageOrVideo,
                              height: 88.h,
                            )),
                        SizedBox(height: 20.h),
                        BlocBuilder<CalenderCubit, CalenderState>(
                            builder: (context, state) {
                              var cubit = context.read<CalenderCubit>();
                              return SizedBox(
                                height: (cubit.myImages?.length == 0 ||
                                    cubit.myImages == null)
                                    ? 0
                                    : 80.h,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: (cubit.myImages?.length ?? 0),
                                  separatorBuilder: (_, __) =>
                                  const SizedBox(width: 10),
                                  itemBuilder: (context, index) {
                                    return Stack(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ImageFileView(
                                                            image: cubit
                                                                .myImages![index]
                                                                .path)));
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            child: Image.file(
                                              File(cubit.myImages![index].path),
                                              width: 80.w,
                                              height: 80.w,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: GestureDetector(
                                            onTap: () {
                                              cubit.deleteImage(File(
                                                  cubit.myImages![index].path));
                                            },
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.black45,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(Icons.close,
                                                  color: Colors.white, size: 18),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              );
                            }),
                        CustomButton(
                            title: "create_jop".tr()),
                      ],
                    ),
                  );
                }
              ),
            ),
          ),

        ],
      ),
    );
  }
}
Widget _label(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.h, top: 16.h),
    child: Text(
      text,
      style: getMediumStyle(
        fontSize: 14.sp,
        color: AppColors.blackLite
      )
    ),
  );
}