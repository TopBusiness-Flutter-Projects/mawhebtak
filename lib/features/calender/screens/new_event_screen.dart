import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mawhebtak/features/calender/cubit/calender_cubit.dart';
import 'package:mawhebtak/features/calender/cubit/calender_state.dart';
import 'package:mawhebtak/features/calender/screens/widgets/public_and_private_widget.dart';
import 'package:mawhebtak/features/calender/screens/widgets/required_talents_selector_widget.dart';
import 'package:mawhebtak/features/calender/screens/widgets/stepper_widget.dart';
import 'package:mawhebtak/features/events/screens/widgets/custom_apply_app_bar.dart';
import '../../../core/exports.dart';
import '../../../core/utils/custom_pick_media.dart';

class NewEventScreen extends StatefulWidget {
  const NewEventScreen({super.key});

  @override
  State<NewEventScreen> createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  int currentStep = 0;
  bool isFree = true;
  final TextEditingController ticketPriceController = TextEditingController();

  List<TalentRequirement> talentRequirements = [
    TalentRequirement(type: 'Workshop', fee: '3000', currency: 'L.E'),
  ];

  @override
  void initState() {
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
    var cubit = context.read<CalenderCubit>();
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBarWithClearWidget(title: "new_event".tr()),
            if (currentStep == 2)
              BlocBuilder<CalenderCubit, CalenderState>(
                  builder: (context, state) {
                return Expanded(
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
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        20.h.verticalSpace,
                        Text(
                          textAlign: TextAlign.center,
                          'event_created_subtext'.tr(),
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        20.h.verticalSpace,
                        SvgPicture.asset(AppIcons.share),
                      ],
                    ),
                  ),
                );
              })
            else
              Expanded(
                child: Column(
                  children: [
                    StepIndicator(
                      currentStep: currentStep + 1,
                      steps: [
                        'event_information'.tr(),
                        'required_talents'.tr()
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: BlocBuilder<CalenderCubit, CalenderState>(
                          builder: (context, state) {
                            return currentStep == 0
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
                          if (currentStep > 0)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  currentStep = 0;
                                });
                              },
                              child: Text(
                                'back'.tr(),
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                          Expanded(
                            child: SizedBox(
                              height: 48.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (currentStep == 0) {
                                    setState(() {
                                      currentStep = 1;
                                    });
                                  } else if (currentStep == 1) {
                                    setState(() {
                                      currentStep = 2;

                                      // cubit.addEvent(
                                      //   title: cubit
                                      //       .titleOfTheEventController.text,
                                      //   date: cubit.selectedDate ??
                                      //       DateTime.now(),
                                      // );

                                      // Navigator.pop(context);
                                    });
                                  } else {
                                    print(
                                        'Form submitted with \${talentRequirements.length} talents');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                child: Text(
                                  currentStep == 0
                                      ? 'next'.tr()
                                      : 'create_event'.tr(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.sp,
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
  }

  Widget _buildEventInformationStep(CalenderCubit cubit) {
    return Column(
      children: [
        //! Select Image
        CustomPickMediaWidget(
          onTap: () {
            //
          },
        ),

        CustomContainerWithShadow(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppIcons.photoIcon),
                    const SizedBox(width: 10),
                    Text("upload_photo".tr(),
                        style: getMediumStyle(fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 80,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: (cubit.myImages?.length ?? 0) + 1,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      if (index == (cubit.myImages?.length ?? 0)) {
                        // "+" Icon at the end
                        return GestureDetector(
                          onTap: () {
                            cubit.pickMultiImage();
                          },
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[300],
                            ),
                            child: const Icon(Icons.add,
                                size: 30, color: Colors.black54),
                          ),
                        );
                      }

                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ImageFileView(
                                          image: File(
                                              cubit.myImages![index].path))));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(cubit.myImages![index].path),
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  cubit.deleteImage(
                                      File(cubit.myImages![index].path));
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
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        //! is free
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
                          'Is this event free?',
                          style: getMediumStyle(
                              fontSize: 20.sp, color: AppColors.grayDark),
                        ),
                      ],
                    ),
                    Switch(
                      value: isFree,
                      activeColor: AppColors.primary,
                      onChanged: (value) {
                        setState(() {
                          isFree = value;
                          if (isFree) ticketPriceController.clear();
                        });
                      },
                    ),
                  ],
                ),
              ),
              if (!isFree)
                DropdownTextFieldWidget(
                  isWithCurrency: true,
                  dataLists: const ["100", "200", "300"],
                  hintText: '1000',
                ),
              _label("title_of_event".tr()),
              CustomTextField(
                controller: cubit.titleOfTheEventController,
                hintText: "",
              ),
              _label("event_date".tr()),
              CustomTextField(
                controller: cubit.eventDateController,
                suffixIcon: Padding(
                  padding: EdgeInsets.all(10.0.r),
                  child: SvgPicture.asset(AppIcons.dateIcon),
                ),
                onTap: () {
                  cubit.selectDateTime(context);
                },
                hintTextSize: 20.sp,
                hintText: "",
              ),
              _label("select_location".tr()),
              CustomTextField(
                onTap: () {},
                hintTextSize: 20.sp,
                hintText: "",
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {},
                  child: Text(
                    "open_map".tr(),
                    style: TextStyle(
                      fontSize: 20.sp,
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
                onTap: () {},
                isMessage: true,
                hintTextSize: 20.sp,
                hintText: "",
              ),
              10.h.verticalSpace,
              PublicPrivateToggle(
                onToggle: (isPublic) {},
              ),
              20.h.verticalSpace,
              Text(
                'event_type'.tr(),
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: DropdownTextFieldWidget(
                  dataLists: const [
                    'Workshop',
                    'Conference',
                    'Seminar',
                    'Webinar',
                    'Meeting'
                  ],
                  hintText: 'Workshop',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRequiredTalentsStep() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: RequiredTalentsSelector(
        initialTalents: talentRequirements,
        onTalentsChanged: (talents) {
          talentRequirements = talents;
        },
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, top: 16.h),
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.blackLite,
          fontWeight: FontWeight.w400,
          fontSize: 20.sp,
        ),
      ),
    );
  }
}
