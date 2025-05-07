import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/features/calender/screens/widgets/price_range_fields.dart';
import 'package:mawhebtak/features/jobs/cubit/jobs_cubit.dart';
import 'package:mawhebtak/features/jobs/cubit/jobs_state.dart';

import '../../events/screens/widgets/custom_apply_app_bar.dart';

class AddNewJobScreen extends StatefulWidget {
  const AddNewJobScreen({super.key});

  @override
  State<AddNewJobScreen> createState() => _AddNewJobScreenState();
}

class _AddNewJobScreenState extends State<AddNewJobScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit =  context.read<JobsCubit>();
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
                  return Padding(
                    padding:  EdgeInsets.only(left: 20.w,right: 20.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label("needed_talent".tr()),
                        const CustomTextField(
                          hintText: "John doe",
                        ),
                         PriceRangeFields(jobsCubit: cubit,),
                        _label("select_location".tr()),
                        CustomTextField(
                          controller:cubit.locationController,
                          onTap: () {},
                          hintTextSize: 14.sp,
                          hintText: "",
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {},
                            child: Text(
                              "open_map".tr(),
                              style: TextStyle(
                                fontSize: 14.sp,
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

                        Wrap(
                          spacing: 5.w,
                          runSpacing: 5.h,
                          children: [
                            ...cubit.uploadedImages.map((file) {
                              return Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: Image.file(
                                      file,
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
                                      cubit.removeImage(file);
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
                              );
                            }),

                            Column(
                              children: [
                                _label("attachment".tr()),
                                GestureDetector(
                                  onTap: () {
                                    cubit.pickImages(context);
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
                          ],
                        ),
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