import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mawhebtak/core/widgets/dropdown_button_form_field.dart';
import 'package:mawhebtak/features/calender/cubit/calender_cubit.dart';
import 'package:mawhebtak/features/calender/cubit/calender_state.dart';
import 'package:mawhebtak/features/calender/screens/widgets/public_and_private_widget.dart';
import 'package:mawhebtak/features/calender/screens/widgets/required_talents_selector_widget.dart';
import 'package:mawhebtak/features/calender/screens/widgets/stepper_widget.dart';
import 'package:mawhebtak/features/casting/cubit/casting_cubit.dart';
import 'package:mawhebtak/features/events/screens/widgets/custom_apply_app_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import '../../../core/exports.dart';
import '../../../core/utils/custom_pick_media.dart';

import '../../feeds/screens/widgets/image_view_file.dart';
import '../../feeds/screens/widgets/video_from_file_screen.dart';
import '../../location/cubit/location_cubit.dart';
import '../../location/cubit/location_state.dart';
import '../../location/screens/full_screen_map.dart';
import '../data/model/countries_model.dart';

class NewEventScreen extends StatefulWidget {
  const NewEventScreen({super.key});

  @override
  State<NewEventScreen> createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  GlobalKey<FormState> formKeyInformation = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<CalenderCubit>().currentStep = 0;
    if (context.read<CalenderCubit>().categoriesMainModel == null) {
      context.read<CalenderCubit>().getAllCategories();
    }
    if (context.read<CalenderCubit>().countriesMainModel == null) {
      context.read<CalenderCubit>().getAllCountries();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalenderCubit, CalenderState>(
      builder: (context, state) {
        var cubit = context.read<CalenderCubit>();

        return SafeArea(
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBarWithClearWidget(title: "new_event".tr()),
                if (cubit.currentStep == 2)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppIcons.successIcon),
                          SizedBox(height: 16.h),
                          Text(
                            'event_created'.tr(),
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          20.h.verticalSpace,
                          Text(
                            textAlign: TextAlign.center,
                            'event_created_subtext'.tr(),
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          20.h.verticalSpace,
                          InkWell(
                              onTap: () async {
                                await SharePlus.instance.share(ShareParams(
                                  text: AppStrings.eventsShareLink +
                                      (cubit.evntStore?.data.toString() ?? ''),
                                  title: AppStrings.appName,
                                ));
                              },
                              child: SvgPicture.asset(AppIcons.share)),
                        ],
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: Column(
                      children: [
                        StepIndicator(
                          currentStep: cubit.currentStep + 1,
                          steps: [
                            'event_information'.tr(),
                            'required_talents'.tr()
                          ],
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: BlocBuilder<CalenderCubit, CalenderState>(
                              builder: (context, state) {
                                return cubit.currentStep == 0
                                    ? _buildEventInformationStep(cubit)
                                    : _buildRequiredTalentsStep();
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                offset: const Offset(0, -2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (cubit.currentStep > 0)
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      cubit.currentStep = 0;
                                    });
                                  },
                                  child: Text(
                                    'back'.tr(),
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                ),
                              Expanded(
                                child: SizedBox(
                                  height: 48.h,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (cubit.currentStep == 0) {
                                        if (formKeyInformation.currentState!
                                            .validate()) {
                                          setState(() {
                                            cubit.currentStep = 1;
                                          });
                                          cubit.getAllSubCategories(cubit
                                                  .selectedCategoty?.id
                                                  .toString() ??
                                              '');
                                        }
                                      } else if (cubit.currentStep == 1) {
                                        cubit.eventStore(context);
                                        // cubit.addEvent(
                                        //   title: cubit
                                        //       .titleOfTheEventController.text,
                                        //   date: cubit.selectedDate ??
                                        //       DateTime.now(),
                                        // );

                                        // Navigator.pop(context);
                                      } else {
                                        print(
                                            'Form submitted with \.length} talents');
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                      ),
                                    ),
                                    child: Text(
                                      cubit.currentStep == 0
                                          ? 'next'.tr()
                                          : 'create_event'.tr(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500,
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
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEventInformationStep(CalenderCubit cubit) {
    return Form(
      key: formKeyInformation,
      child: Column(
        children: [
          //! Select Image
          CustomPickMediaWidget(
            onTap: () {
              log('00');
              cubit.showSelectionBottomSheet(context);
            },
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: (cubit.myImages?.length == 0 || cubit.myImages == null)
                ? 0
                : 80.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: (cubit.myImages?.length ?? 0),
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageFileView(
                                    image: cubit.myImages![index].path)));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
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
                          cubit.deleteImage(File(cubit.myImages![index].path));
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
          SizedBox(height: 10.h),
          SizedBox(
            height: cubit.validVideos.isEmpty ? 0 : 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: (cubit.validVideos.length),
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoPlayerScreenFile(
                                  videoFile:
                                      File(cubit.validVideos[index].path),
                                )));
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 80.w,
                          height: 80.w,
                          color: Colors.black12,
                          child: const Center(
                            child: Icon(Icons.play_circle_fill,
                                size: 40, color: Colors.grey),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              cubit.deleteVideo(
                                  File(cubit.validVideos[index].path));
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

          //! is free
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.event_available, color: AppColors.primary),
                          SizedBox(width: 10.w),
                          Text(
                            'is_free'.tr(),
                            style: getMediumStyle(
                                fontSize: 18.sp, color: AppColors.grayDark),
                          ),
                        ],
                      ),
                      Switch(
                        value: cubit.isFree,
                        activeColor: AppColors.primary,
                        onChanged: (value) {
                          setState(() {
                            cubit.isFree = !cubit.isFree;
                            if (cubit.isFree) {
                              cubit.ticketPriceController.clear();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),

                if (!cubit.isFree)
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return 'enter_ticket_price'.tr();
                      }
                      return null;
                    },
                    controller: cubit.ticketPriceController,
                    hintText: 'ticket_price'.tr(),
                    hintTextSize: 18.sp,
                    enabled: true,
                    suffixIcon: InkWell(
                      onTap: () {
                        showCurrencyPicker(
                            cubit.countriesMainModel?.data ?? []);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            cubit.selectedCurrency?.currency ?? 'L.E',
                            style: getRegularStyle(
                                color: Colors.blue, fontSize: 14.sp),
                          ),
                          const Icon(Icons.keyboard_arrow_down_sharp,
                              color: Colors.blue),
                        ],
                      ),
                    ),
                  ),
                _label("event_limit".tr()),

                CustomTextField(
                  keyboardType: TextInputType.number,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'please_enter_event_limit'.tr();
                    }
                    return null;
                  },
                  controller: cubit.eventLimitController,
                  hintText: '150',
                  hintTextSize: 18.sp,
                  enabled: true,
                ),

                _label("title_of_event".tr()),
                CustomTextField(
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'title_of_event'.tr();
                    }
                    return null;
                  },
                  controller: cubit.titleOfTheEventController,
                  hintText: "title_of_event".tr(),
                ),
                //! Time
                _label("event_date_from".tr()),
                CustomTextField(
                  controller: cubit.eventDateController,
                  enabled: true,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return 'event_date_from'.tr();
                    }
                    return null;
                  },
                  suffixIcon: InkWell(
                    onTap: () {
                      cubit.selectDateTime(context, isFrom: false);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10.0.r),
                      child: SvgPicture.asset(AppIcons.dateIcon),
                    ),
                  ),
                  onTap: () {
                    cubit.selectDateTime(context, isFrom: false);
                  },
                  hintTextSize: 18.sp,
                  keyboardType: TextInputType.datetime,
                  hintText: "event_date_from".tr(),
                ),
                _label("event_date_to".tr()),
                CustomTextField(
                  enabled: true,
                  keyboardType: TextInputType.datetime,
                  controller: cubit.eventToDateController,
                  suffixIcon: InkWell(
                    onTap: () {
                      cubit.selectDateTime(context, isFrom: true);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10.0.r),
                      child: SvgPicture.asset(AppIcons.dateIcon),
                    ),
                  ),
                  onTap: () {
                    cubit.selectDateTime(context, isFrom: true);
                  },
                  hintTextSize: 18.sp,
                  hintText: "event_date_to".tr(),
                ),
                //! Location
                _label("select_location".tr()),
                BlocBuilder<LocationCubit, LocationState>(
                  builder: (context, state) {
                    return CustomTextField(
                      hintTextSize: 18.sp,
                      controller: cubit.locationAddressController,
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
                                    type: 'event',
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
                _label("description".tr()),
                CustomTextField(
                  controller: cubit.descriptionController,
                  isMessage: true,
                  hintTextSize: 18.sp,
                  hintText: "description_msg".tr(),
                ),
                10.h.verticalSpace,
                PublicPrivateToggle(
                  isPublic: cubit.isPublic,
                  onToggle: (isPublic) {
                    cubit.isPublic = isPublic;
                    log("000000 $isPublic");
                    log("111111 ${cubit.isPublic}");
                  },
                ),
                20.h.verticalSpace,
                Text(
                  'event_type'.tr(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: GeneralCustomDropdownButtonFormField<
                      GetCountriesMainModelData>(
                    items: cubit.categoriesMainModel?.data ?? [],
                    itemBuilder: (item) {
                      return item.name ?? '';
                    },
                    value: cubit.selectedCategoty,
                    onChanged: (value) {
                      cubit.selectedCategoty = value;
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'event_type'.tr();
                      }
                      return null;
                    },
                  ),
                ),
              ],
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

  Widget _buildRequiredTalentsStep() {
    return Padding(
        padding: EdgeInsets.all(20.w), child: const RequiredTalentsSelector());
  }

  Widget _label(String text) {
    return Padding(
        padding: EdgeInsets.only(bottom: 8.h, top: 16.h),
        child: Text(text,
            style: TextStyle(
                color: AppColors.blackLite,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp)));
  }
}
