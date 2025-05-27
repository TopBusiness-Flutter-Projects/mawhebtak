import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:mawhebtak/core/widgets/dropdown_button_form_field.dart';
import 'package:mawhebtak/features/events/screens/widgets/custom_apply_app_bar.dart';
import 'package:mawhebtak/core/utils/custom_pick_media.dart';
import '../../../core/exports.dart';
import '../../calender/cubit/calender_cubit.dart';
import '../../calender/cubit/calender_state.dart';
import '../../feeds/screens/widgets/image_view_file.dart';
import '../../feeds/screens/widgets/video_from_file_screen.dart';
import '../../home/screens/widgets/follow_button.dart';
import '../cubit/event_cubit.dart';
import '../data/model/event_details_model.dart';

class ApplyForEvent extends StatefulWidget {
  const ApplyForEvent({super.key});

  @override
  State<ApplyForEvent> createState() => _ApplyForEventState();
}

class _ApplyForEventState extends State<ApplyForEvent> {
  var key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalenderCubit, CalenderState>(
      builder: (context, state) {
        var cubit2 = context.read<CalenderCubit>();
        return BlocBuilder<EventCubit, EventState>(
          builder: (BuildContext context, state) {
            var cubit = context.read<EventCubit>();

            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
              ),
              child: Scaffold(
                backgroundColor: AppColors.white,
                body: SingleChildScrollView(
                  child: Form(
                    key: key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAppBarWithClearWidget(
                          title: "apply_for_event".tr(),
                        ),
                        SizedBox(height: getHeightSize(context) / 33),
                        CustomPickMediaWidget(
                          onTap: () {
                            cubit2.showSelectionBottomSheet(context);
                          },
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: (cubit2.myImages?.length == 0 ||
                                    cubit2.myImages == null)
                                ? 0
                                : 80.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: (cubit2.myImages?.length ?? 0),
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
                                                        image: cubit2
                                                            .myImages![index]
                                                            .path)));
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          File(cubit2.myImages![index].path),
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
                                          cubit2.deleteImage(File(
                                              cubit2.myImages![index].path));
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
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: cubit2.validVideos.isEmpty ? 0 : 80,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: (cubit2.validVideos.length),
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 10),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VideoPlayerScreenFile(
                                                  videoFile: File(cubit2
                                                      .validVideos[index].path),
                                                )));
                                  },
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          width: 80.w,
                                          height: 80.w,
                                          decoration: const BoxDecoration(
                                            color: Colors.black12,
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  ImageAssets.videoImage),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              cubit2.deleteVideo(File(cubit2
                                                  .validVideos[index].path));
                                            });
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
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0.w, vertical: 3.h),
                          child: Text(
                            'expected_fees'.tr(),
                            style: getMediumStyle(
                                fontSize: 14.sp, color: AppColors.darkGray),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 21.0.w),
                          child: CustomTextField(
                            controller: cubit.priceApplyController,
                            hintText: '100',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please_fill_all_fields'.tr();
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0.w, vertical: 3.h),
                          child: Text(
                            'event_req'.tr(),
                            style: getMediumStyle(
                                fontSize: 14.sp, color: AppColors.darkGray),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0.w, vertical: 10.h),
                            child: GeneralCustomDropdownButtonFormField<
                                Requirement>(
                              items:
                                  cubit.eventDetails?.data?.requirements ?? [],
                              itemBuilder: (item) {
                                return item.subCategory ?? '';
                              },
                              validator: (p0) {
                                if (p0 == null) {
                                  return 'please_fill_all_fields'.tr();
                                }
                                return null;
                              },
                              value: cubit.selectedRequirement,
                              onChanged: (value) {
                                cubit.selectedRequirement = value;
                              },
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0.w, vertical: 3.h),
                          child: Text(
                            'specify_needs'.tr(),
                            style: getMediumStyle(
                                fontSize: 14.sp, color: AppColors.darkGray),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 21.0.w),
                          child: CustomTextField(
                            hintText: "description_here".tr(),
                            isMessage: true,
                            controller: cubit.noteApplyController,
                            validator: (p0) {
                              if (p0 == null || p0.isEmpty) {
                                return 'please_fill_all_fields'.tr();
                              }
                              return null;
                            },
                          ),
                        ),
                        Center(
                          child: CustomContainerButton(
                            title: "apply".tr(),
                            onTap: () {
                              if (key.currentState!.validate()) {
                                cubit.applyToEvent(
                                    cubit.eventDetails?.data?.id.toString() ??
                                        '',
                                    context);
                              }
                            },
                            color: AppColors.primary,
                            width: 327.w,
                            height: 48.h,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

Widget _label(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.h, top: 16.h),
    child: Text(
      text,
      style: TextStyle(
        color: AppColors.blackLite,
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
      ),
    ),
  );
}
