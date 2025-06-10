import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/calender/cubit/calender_cubit.dart';
import 'package:mawhebtak/features/calender/screens/widgets/calender_widget.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_top_event.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/exports.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/utils/check_login.dart';
import '../../home/screens/widgets/custom_app_bar_row.dart';
import '../cubit/calender_state.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int selectedIndex = 0;
  final List<String> roles = ["calendar".tr(), "my_event_list".tr()];

  @override
  void initState() {
    Preferences.instance.getUserModel().then((user) {
      if (user.data?.token == null) {
        checkLogin(context);
      } else {
        context.read<CalenderCubit>().getMyEvents();
        context.read<CalenderCubit>().getCalendarEvent();
      }
    });

    super.initState();
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final user = await Preferences.instance.getUserModel();
        if (user.data?.token == null) {
          checkLogin(context);
        } else {
          Navigator.pushNamed(context, Routes.newEventRoute);
        }
      },
      child: Container(
        width: 60.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: const Center(child: Icon(Icons.add, color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalenderCubit, CalenderState>(
      builder: (context, state) {
        var cubit = context.read<CalenderCubit>();
        return Scaffold(
          floatingActionButton: (selectedIndex != 0)
              ? Container()
              : Padding(
                  padding:
                      const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
                  child: _buildAddButton(context)),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          backgroundColor: AppColors.white,
          body: Column(children: [
            Padding(
              padding: EdgeInsets.only(top: 40.h),
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
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20.h, left: 30.w, right: 30.w, bottom: 20.h),
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
                                  bool isSelected = selectedIndex == index;
                                  return Expanded(
                                    child: GestureDetector(
                                      onTap: () =>
                                          setState(() => selectedIndex = index),
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 0.w),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          color: isSelected
                                              ? AppColors.secondPrimary
                                              : Colors.transparent,
                                          boxShadow: isSelected
                                              ? [
                                                  BoxShadow(
                                                    color: AppColors.primary
                                                        .withOpacity(0.2),
                                                    blurRadius: 6,
                                                    offset: const Offset(0, 2),
                                                  )
                                                ]
                                              : null,
                                        ),
                                        child: Center(
                                          child: Text(
                                            roles[index],
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: isSelected
                                                  ? FontWeight.w600
                                                  : FontWeight.w500,
                                              color: isSelected
                                                  ? AppColors.white
                                                  : AppColors.grayDark
                                                      .withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ))),
                    ),
                  ),
                  10.h.verticalSpace,
                  selectedIndex == 0
                      ? Expanded(
                          child: (state is GetMyCalenderEventLoadingState)
                              ? const Center(
                                  child: CustomLoadingIndicator(),
                                )
                              : const CalendarWidget(),
                        )
                      : Expanded(
                          child: (state is GetMyEventLoadingState)
                              ? const Center(
                                  child: CustomLoadingIndicator(),
                                )
                              : (state is GetMyEventErrorState ||
                                      cubit.myEventsModel?.data?.length == 0)
                                  ? Center(
                                      child: TextButton(
                                        child: Text(
                                          "retry".tr(),
                                        ),
                                        onPressed: () {
                                          cubit.getMyEvents();
                                        },
                                      ),
                                    )
                                  : RefreshIndicator(
                                      onRefresh: () async {
                                        cubit.getMyEvents();
                                      },
                                      child: ListView.separated(
                                          padding: EdgeInsets.only(
                                            bottom: 70.h,
                                          ),
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                          itemCount: cubit.myEventsModel?.data
                                                  ?.length ??
                                              0,
                                          itemBuilder: (context, index) =>
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 20.w, right: 20.w),
                                                child: CustomTopEventList(
                                                  topEvent: cubit.myEventsModel
                                                      ?.data?[index],
                                                  isAll: true,
                                                ),
                                              )),
                                    ))
                ],
              ),
            ),
          ]),
        );
      },
    );
  }
}
