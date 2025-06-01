import 'dart:io';
import 'package:flutter_svg/svg.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/features/calender/cubit/calender_cubit.dart';
import 'package:mawhebtak/features/calender/cubit/calender_state.dart';
import 'package:mawhebtak/features/calender/data/model/countries_model.dart';
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
  void initState() {
    if (context.read<CalenderCubit>().countriesMainModel == null) {
      context.read<CalenderCubit>().getAllCountries();
    }
    super.initState();
  }

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
              child: BlocBuilder<CalenderCubit, CalenderState>(
                  builder: (context, stateCalender) {
                var calenderCubit = context.read<CalenderCubit>();
                return BlocBuilder<JobsCubit, JobsState>(
                    builder: (context, state) {
                  var jopCubit = context.read<JobsCubit>();
                  final formKey = GlobalKey<FormState>();
                  return Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _label("needed_talent".tr()),
                          CustomTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'enter_title'.tr();
                              }
                              return null;
                            },
                            controller: jopCubit.jopUserTitleController,
                            hintText: "John doe",
                          ),
                          Text(
                            'price_range'.tr(),
                            style: getMediumStyle(
                                fontSize: 14.sp, color: AppColors.blackLite),
                          ),
                          CustomTextField(
                            keyboardType: TextInputType.number,
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'price_start_at'.tr();
                              }
                              return null;
                            },
                            controller: jopCubit.priceStartAt,
                            hintText: 'price_start_at'.tr(),
                            hintTextSize: 18.sp,
                            enabled: true,
                            suffixIcon: InkWell(
                              onTap: () {
                                showCurrencyPicker(
                                    calenderCubit.countriesMainModel?.data ??
                                        []);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    calenderCubit.selectedCurrency?.currency ??
                                        'L.E',
                                    style: getRegularStyle(
                                        color: Colors.blue, fontSize: 14.sp),
                                  ),
                                  const Icon(Icons.keyboard_arrow_down_sharp,
                                      color: Colors.blue),
                                ],
                              ),
                            ),
                          ),
                          CustomTextField(
                            keyboardType: TextInputType.number,
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'price_end_at'.tr();
                              }
                              return null;
                            },
                            controller: jopCubit.priceEndAt,
                            hintText: 'price_end_at'.tr(),
                            hintTextSize: 18.sp,
                            enabled: true,
                            suffixIcon: InkWell(
                              onTap: () {
                                showCurrencyPicker(
                                    calenderCubit.countriesMainModel?.data ??
                                        []);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    calenderCubit.selectedCurrency?.currency ??
                                        'L.E',
                                    style: getRegularStyle(
                                        color: Colors.blue, fontSize: 14.sp),
                                  ),
                                  const Icon(Icons.keyboard_arrow_down_sharp,
                                      color: Colors.blue),
                                ],
                              ),
                            ),
                          ),
                          _label("select_location".tr()),
                          BlocBuilder<LocationCubit, LocationState>(
                            builder: (context, state) {
                              return CustomTextField(
                                hintTextSize: 18.sp,
                                controller: jopCubit.locationController,
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
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'select_date'.tr();
                              }
                              return null;
                            },
                            controller: jopCubit.eventDateController,
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(10.0.r),
                              child: SvgPicture.asset(AppIcons.dateIcon),
                            ),
                            onTap: () {
                              jopCubit.selectDateTime(context);
                            },
                            hintTextSize: 14.sp,
                            hintText: "",
                          ),
                          _label("description".tr()),
                          CustomTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'enter_description'.tr();
                              }
                              return null;
                            },
                            controller: jopCubit.descriptionController,
                            isMessage: true,
                          ),
                          Text(
                            "image_or_video".tr(),
                            style: getRegularStyle(fontSize: 14.sp),
                          ),
                          10.verticalSpace,
                          InkWell(
                              onTap: () {
                                calenderCubit.showSelectionBottomSheet(context);
                              },
                              child: Image.asset(
                                ImageAssets.imageOrVideo,
                                height: 88.h,
                              )),
                          SizedBox(height: 20.h),
                          SizedBox(
                            height: (calenderCubit.myImages?.length == 0 ||
                                    calenderCubit.myImages == null)
                                ? 0
                                : 80.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: (calenderCubit.myImages?.length ?? 0),
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
                                                        image: calenderCubit
                                                            .myImages![index]
                                                            .path)));
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.file(
                                          File(calenderCubit
                                              .myImages![index].path),
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
                                          calenderCubit.deleteImage(File(
                                              calenderCubit
                                                  .myImages![index].path));
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
                          CustomButton(
                            onTap: () {
                              final jopCubit = context.read<JobsCubit>();
                              final start =
                                  double.tryParse(jopCubit.priceStartAt.text);
                              final end =
                                  double.tryParse(jopCubit.priceEndAt.text);

                              if (formKey.currentState!.validate()) {
                                if (start == null || end == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'please_enter_valid_price'.tr())),
                                  );
                                  return;
                                }

                                if (start >= end) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'enter_end_price_must_greater_than_start_price'
                                                .tr())),
                                  );
                                  return;
                                }

                                jopCubit.addJopUser(context: context);
                              }
                            },
                            title: "create_jop".tr(),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              }),
            ),
          ),
        ],
      ),
    );
  }

  void showCurrencyPicker(List<GetCountriesMainModelData> currencyList) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: currencyList.map((currency) {
            return ListTile(
              title: Text(currency.currency ?? '', style: getRegularStyle()),
              onTap: () {
                setState(() =>
                    context.read<CalenderCubit>().selectedCurrency = currency);

                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

Widget _label(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.h, top: 16.h),
    child: Text(text,
        style: getMediumStyle(fontSize: 14.sp, color: AppColors.blackLite)),
  );
}
