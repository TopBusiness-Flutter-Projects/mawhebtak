import 'package:mawhebtak/features/calender/screens/widgets/calender_widget.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_top_event.dart';
import '../../../core/exports.dart';
import '../../home/screens/widgets/custom_app_bar_row.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int selectedIndex = 0;
  final List<String> roles = ["Calendar", "My Events List"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
            child: CustomAppBarRow(
              colorTextFromSearchTextField: AppColors.darkGray.withOpacity(0.3),
              backgroundColorTextFieldSearch: AppColors.grayLite,
              isMore: true,
              colorSearchIcon: AppColors.secondPrimary,
              backgroundNotification: AppColors.primary,
            ),
          ),
          SizedBox(height: 5.h),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  color: AppColors.grayLite,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 2.r),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                    ),
                    child: Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                top: 20.h, left: 18.w, right: 18.w),
                            child: Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              padding: EdgeInsets.all(4.w),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: roles.length,
                                itemBuilder: (context, index) {
                                  bool isSelected = selectedIndex == index;
                                  return GestureDetector(
                                    onTap: () =>
                                        setState(() => selectedIndex = index),
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 4.w),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40.w, vertical: 8.h),
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
                                            fontSize: 13.sp,
                                            fontWeight: isSelected
                                                ? FontWeight.w600
                                                : FontWeight.w500,
                                            color: isSelected
                                                ? AppColors.white
                                                : AppColors.grayDark
                                                    .withOpacity(0.5),
                                            fontFamily:
                                                'Noto Sans', // يمكن استبداله بأي خط تفضله
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )),
                        20.h.verticalSpace,
                        selectedIndex == 0
                            ? const Expanded(
                                child: CalendarWidget(),
                              )
                            : Expanded(
                                child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                    itemCount: 2,
                                    itemBuilder: (context, index) => Padding(
                                          padding: EdgeInsets.only(
                                              left: 20.w, right: 20.w),
                                          child: const CustomTopEventList(
                                            isAll: true,
                                          ),
                                        )),
                              )
                      ],
                    ),
                  ),
                )),
          ),
        ]),
      ),
    );
  }
}
