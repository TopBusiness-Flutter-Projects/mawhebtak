import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/features/casting/cubit/casting_cubit.dart';
import 'package:mawhebtak/features/casting/cubit/casting_state.dart';
import 'package:mawhebtak/features/casting/screens/widgets/gigs_widgets.dart';
import 'package:mawhebtak/features/casting/screens/widgets/talents_widget.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_app_bar_row.dart';
import '../../../core/exports.dart';
import '../../home/screens/widgets/custom_request_gigs.dart';

class CastingScreen extends StatefulWidget {
  const CastingScreen({super.key, required this.isFromHome});
  final bool isFromHome;
  @override
  State<CastingScreen> createState() => _CastingScreenState();
}

class _CastingScreenState extends State<CastingScreen> {
  int selectedIndex = 0;

  final List<String> roles = ["talents".tr(), "gigs".tr()];

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CastingCubit>();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            if (widget.isFromHome != true)
              CustomSimpleAppbar(
                title: 'casting'.tr(),
                isActionButton: true,
              ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
              child: CustomAppBarRow(
                colorTextFromSearchTextField:
                    AppColors.darkGray.withOpacity(0.3),
                backgroundColorTextFieldSearch: AppColors.grayLite,
                isMore: true,
                colorSearchIcon: AppColors.secondPrimary,
                backgroundNotification: AppColors.primary,
              ),
            ),
            SizedBox(height: 5.h),
            BlocBuilder<CastingCubit, CastingState>(builder: (context, state) {
              return Expanded(
                child: Stack(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: AppColors.grayLite,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 2.r),
                          child: Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: 20.h,
                                      left: 55.w,
                                      right: 55.w,
                                      bottom: 20.h),
                                  child: Container(
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Center(
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: List.generate(
                                              roles.length,
                                              (index) {
                                                bool isSelected =
                                                    selectedIndex == index;
                                                return Expanded(
                                                  child: GestureDetector(
                                                    onTap: () => setState(() =>
                                                        selectedIndex = index),
                                                    child: AnimatedContainer(
                                                      duration: const Duration(
                                                          milliseconds: 300),
                                                      curve: Curves.easeInOut,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 0.w),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r),
                                                        color: isSelected
                                                            ? AppColors
                                                                .secondPrimary
                                                            : Colors
                                                                .transparent,
                                                        boxShadow: isSelected
                                                            ? [
                                                                BoxShadow(
                                                                  color: AppColors
                                                                      .primary
                                                                      .withOpacity(
                                                                          0.2),
                                                                  blurRadius: 6,
                                                                  offset:
                                                                      const Offset(
                                                                          0, 2),
                                                                )
                                                              ]
                                                            : null,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          roles[index],
                                                          style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                isSelected
                                                                    ? FontWeight
                                                                        .w600
                                                                    : FontWeight
                                                                        .w500,
                                                            color: isSelected
                                                                ? AppColors
                                                                    .white
                                                                : AppColors
                                                                    .grayDark
                                                                    .withOpacity(
                                                                        0.5),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ))),
                                  )),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 145.w, // Match image width
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          itemCount: cubit.items.length,
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return CustomRequestGigsList(
                                              isLeftPadding:
                                                  index == 0 ? true : false,
                                              isRightPadding: index ==
                                                      cubit.items.length - 1
                                                  ? true
                                                  : false,
                                            );
                                          },
                                        ),
                                      ),
                                      if (selectedIndex == 0)
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w,
                                                  vertical: 10.h),
                                              child: Text(
                                                "talents".tr(),
                                                style: TextStyle(
                                                    color: AppColors.blackLite,
                                                    fontSize: 16.sp),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10.w, right: 10.w),
                                              child: GridView.builder(
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  mainAxisSpacing: 16.h,
                                                  crossAxisSpacing: 16.w,
                                                  childAspectRatio:
                                                      0.75, // Adjust this ratio to control card proportions
                                                ),
                                                scrollDirection: Axis.vertical,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: 5,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return TalentList(
                                                      index: index);
                                                },
                                              ),
                                            ),
                                          ],
                                        )
                                      else
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w,
                                                  vertical: 10.h),
                                              child: Text(
                                                "gigs_list".tr(),
                                                style: TextStyle(
                                                    color: AppColors.blackLite,
                                                    fontSize: 16.sp),
                                              ),
                                            ),
                                            ListView.builder(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.w),
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  5, // Replace with your actual item count
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return GigsWidget(
                                                  isWithButton: true,
                                                );
                                              },
                                            ),
                                          ],
                                        )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                    Positioned(
                      bottom: 10.h,
                      right: 20.w,
                      child: GestureDetector(
                        onTap: () {},
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
              );
            }),
            if (widget.isFromHome != false) 100.h.verticalSpace,
          ],
        ),
      ),
    );
  }
}
