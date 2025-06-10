import 'dart:developer';

import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/utils/hex_color.dart';
import 'package:mawhebtak/features/calender/cubit/calender_cubit.dart';
import '../../../../core/exports.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../../core/utils/check_login.dart';
import '../../cubit/calender_state.dart';
import '../../data/repos/model/calender_model.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime currentDate = DateTime.now();
  late List<MainCalendarEventData> events;

  // // ----------------------------
  // // عرض مودال إضافة حدث جديد
  // // ----------------------------
  // void _showAddEventModal(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: AppColors.white,
  //     isScrollControlled: true,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
  //     ),
  //     builder: (context) {
  //       String eventTitle = '';
  //       DateTime? startDate;
  //       DateTime? endDate;
  //
  //       return StatefulBuilder(
  //         builder: (context, setModalState) {
  //           return Padding(
  //             padding: EdgeInsets.only(
  //               bottom: MediaQuery.of(context).viewInsets.bottom,
  //               top: 16.h,
  //               right: 16.w,
  //               left: 16.w,
  //             ),
  //             child: SingleChildScrollView(
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //
  //                   // حقل العنوان
  //                   Text("Event Title", style: TextStyle(color: AppColors.blackLite, fontSize: 14.sp)),
  //                   CustomTextField(
  //                     hintText: "Event Title",
  //                     onChanged: (value) => eventTitle = value,
  //                   ),
  //
  //                   SizedBox(height: 10.h),
  //
  //                   // اختيار التواريخ
  //                   Row(
  //                     children: [
  //                       // زر اختيار تاريخ البداية
  //                       Expanded(
  //                         child: ElevatedButton(
  //                           onPressed: () async {
  //                             final date = await showDatePicker(
  //                               context: context,
  //                               initialDate: DateTime.now(),
  //                               firstDate: DateTime(2000),
  //                               lastDate: DateTime(2100),
  //                             );
  //                             if (date != null) {
  //                               setModalState(() {
  //                                 startDate = date;
  //                               });
  //                             }
  //                           },
  //                           style: ElevatedButton.styleFrom(
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(12.r),
  //                             ),
  //                             padding: EdgeInsets.symmetric(vertical: 16.h),
  //                             elevation: 6,
  //                             shadowColor: Colors.deepPurpleAccent.withOpacity(0.3),
  //                             side: BorderSide(color: AppColors.primary, width: 2),
  //                           ),
  //                           child: Text(
  //                             startDate == null
  //                                 ? "Select Start Date"
  //                                 : "From: ${DateFormat.yMd().format(startDate!)}",
  //                             style: TextStyle(
  //                               fontSize: 14.sp,
  //                               fontWeight: FontWeight.w600,
  //                               letterSpacing: 1.0,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //
  //                       SizedBox(width: 16.w),
  //
  //                       // زر اختيار تاريخ النهاية
  //                       Expanded(
  //                         child: ElevatedButton(
  //                           onPressed: () async {
  //                             final date = await showDatePicker(
  //                               context: context,
  //                               initialDate: startDate ?? DateTime.now(),
  //                               firstDate: DateTime(2000),
  //                               lastDate: DateTime(2100),
  //                             );
  //                             if (date != null) {
  //                               setModalState(() {
  //                                 endDate = date;
  //                               });
  //                             }
  //                           },
  //                           style: ElevatedButton.styleFrom(
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(12.r),
  //                             ),
  //                             padding: EdgeInsets.symmetric(vertical: 16.h),
  //                             elevation: 4,
  //                             shadowColor: Colors.deepPurpleAccent.withOpacity(0.3),
  //                             side: BorderSide(color: AppColors.primary, width: 2),
  //                           ),
  //                           child: Text(
  //                             endDate == null
  //                                 ? "Select End Date"
  //                                 : "To: ${DateFormat.yMd().format(endDate!)}",
  //                             style: TextStyle(
  //                               fontSize: 14.sp,
  //                               fontWeight: FontWeight.w600,
  //                               letterSpacing: 1.0,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //
  //                   SizedBox(height: 10.h),
  //
  //                   // زر تأكيد إضافة الحدث
  //                   CustomButton(
  //                     title: "Add Event",
  //                     onTap: () {
  //                       if (eventTitle.isNotEmpty && startDate != null) {
  //                         final newEvent = CalendarEvent(
  //                           title: eventTitle,
  //                           date: startDate!,
  //                           endDate: endDate != null && endDate!.isAfter(startDate!)
  //                               ? endDate
  //                               : null,
  //                           color: Colors.deepPurpleAccent,
  //                         );
  //
  //                         // إغلاق المودال ثم تحديث واجهة التقويم
  //                         Navigator.pop(context);
  //                         WidgetsBinding.instance.addPostFrameCallback((_) {
  //                           setState(() {
  //                             events.add(newEvent);
  //                           });
  //                         });
  //                       }
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();
    events = context.read<CalenderCubit>().events;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalenderCubit, CalenderState>(
      builder: (context, state) {
        return Stack(
          children: [
            // ------------------------
            // الجسم الرئيسي للتقويم
            // ------------------------
            Column(
              children: [
                _buildMonthNavigator(),
                10.h.verticalSpace,
                _buildWeekdayHeader(),
                Expanded(child: _buildCalendarBody()),
                50.h.verticalSpace,
              ],
            ),

            // ------------------------
            // زر عائم لإضافة حدث
            // ------------------------
          ],
        );
      },
    );
  }

  // التنقل بين الشهور
  Widget _buildMonthNavigator() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNavigatorButton(
            icon: Icons.arrow_back,
            onTap: () {
              setState(() {
                currentDate = DateTime(currentDate.year, currentDate.month - 1);
              });
            },
          ),
          Text(
            DateFormat('MMMM yyyy').format(currentDate),
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
          _buildNavigatorButton(
            icon: Icons.arrow_forward,
            onTap: () {
              setState(() {
                currentDate = DateTime(currentDate.year, currentDate.month + 1);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavigatorButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Material(
        color: Colors.cyan.shade50,
        borderRadius: BorderRadius.circular(8.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            padding: EdgeInsets.all(8.r),
            child: Icon(icon, color: Colors.cyan, size: 16.sp),
          ),
        ),
      ),
    );
  }

  // عناوين أيام الأسبوع
  Widget _buildWeekdayHeader() {
    final weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Row(
      children: weekdays.map((day) {
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.grayLite.withOpacity(0.5),
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 11.h),
            child: Text(
              day,
              style: TextStyle(
                color: Colors.blue.shade700,
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // جسم التقويم (الأيام والأحداث)
  Widget _buildCalendarBody() {
    List<DateTime> days = _getCalendarDays();
    List<List<DateTime>> weeks = [];

    for (int i = 0; i < days.length; i += 7) {
      weeks.add(days.sublist(i, i + 7));
    }

    return Column(
      children: weeks.asMap().entries.map((weekEntry) {
        List<DateTime> week = weekEntry.value;

        return Expanded(
          child: Stack(
            children: [
              Row(
                children: week.map((day) {
                  bool isCurrentMonth = day.month == currentDate.month;
                  List<MainCalendarEventData> dayEvents = events
                      .where(
                        (event) =>
                            isSameDay(event.start ?? DateTime.now(), day) &&
                            event.end == null,
                      )
                      .toList();

                  return Expanded(
                    child: _buildCalendarCell(day, isCurrentMonth, dayEvents),
                  );
                }).toList(),
              ),
              ..._buildMultidayEventRow(week),
            ],
          ),
        );
      }).toList(),
    );
  }

  // الأحداث متعددة الأيام
  List<Widget> _buildMultidayEventRow(List<DateTime> week) {
    List<MultidayEventPosition> weekEvents = events
        .where((e) => e.end != null)
        .map((e) {
          int start = -1, end = -1;
          for (int i = 0; i < week.length; i++) {
            if (isDateInRange(week[i], e.start ?? DateTime.now(), e.end!)) {
              if (start == -1) start = i;
              end = i;
            }
          }
          return start != -1
              ? MultidayEventPosition(
                  event: e, startIndex: start, endIndex: end)
              : null;
        })
        .whereType<MultidayEventPosition>()
        .toList();

    return weekEvents.map((eventPos) {
      double left =
          (eventPos.startIndex / 7) * MediaQuery.of(context).size.width;
      double right =
          ((6 - eventPos.endIndex) / 7) * MediaQuery.of(context).size.width;

      return Positioned(
        top: 30.h,
        left: left,
        right: right,
        child: InkWell(
          onTap: () {
            mainAppAwsomeDialog(context, onPressed: () {
              Navigator.pushNamed(context, Routes.detailsEventRoute,
                  arguments: eventPos.event.id?.toString());
            }, title: 'do_you_want_nav_to_details'.tr(), btnOkText: 'go'.tr());

            log('event start ${eventPos.event.start} end ${eventPos.event.end}');
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Container(
              height: 30.h,
              decoration: BoxDecoration(
                color: AppColors.secondPrimary,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(20.r),
                  right: Radius.circular(20.r),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              alignment: Alignment.centerLeft,
              child: Text(
                eventPos.event.title ?? '',
                style: TextStyle(color: Colors.white, fontSize: 10.sp),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  // بناء خلية في التقويم
  Widget _buildCalendarCell(DateTime day, bool isCurrentMonth,
      List<MainCalendarEventData> dayEvents) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // رقم اليوم
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
            child: Text(
              day.day.toString(),
              style: TextStyle(
                color: isCurrentMonth ? Colors.black87 : Colors.grey.shade400,
                fontSize: 12.sp,
              ),
            ),
          ),

          // الأحداث اليومية
          ...dayEvents.map((event) {
            return InkWell(
              onTap: () {
                mainAppAwsomeDialog(context, onPressed: () {
                  Navigator.pushNamed(context, Routes.detailsEventRoute,
                      arguments: event.id?.toString());
                },
                    title: 'do_you_want_nav_to_details'.tr(),
                    btnOkText: 'go'.tr());

                log('event start ${event.start} end ${event.end}');
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor(event.color ?? '#000000'),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Text(
                    event.title ?? '',
                    style: TextStyle(color: Colors.white, fontSize: 10.sp),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // تجهيز قائمة الأيام في الشهر الحالي + الأيام السابقة واللاحقة لتغطية الأسابيع
  List<DateTime> _getCalendarDays() {
    final daysInMonth =
        DateTime(currentDate.year, currentDate.month + 1, 0).day;
    final firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);
    final firstWeekdayOfMonth = firstDayOfMonth.weekday % 7;

    final daysFromPreviousMonth = firstWeekdayOfMonth;
    final totalDays = daysFromPreviousMonth + daysInMonth;
    final totalWeeks = (totalDays / 7).ceil();
    final totalCells = totalWeeks * 7;

    List<DateTime> calendarDays = [];

    // أيام من الشهر السابق
    final lastDayOfPreviousMonth =
        DateTime(currentDate.year, currentDate.month, 0).day;
    for (int i = 0; i < daysFromPreviousMonth; i++) {
      final day = lastDayOfPreviousMonth - daysFromPreviousMonth + i + 1;
      calendarDays.add(DateTime(currentDate.year, currentDate.month - 1, day));
    }

    // أيام الشهر الحالي
    for (int i = 1; i <= daysInMonth; i++) {
      calendarDays.add(DateTime(currentDate.year, currentDate.month, i));
    }

    // أيام من الشهر القادم
    final remainingCells = totalCells - calendarDays.length;
    for (int i = 1; i <= remainingCells; i++) {
      calendarDays.add(DateTime(currentDate.year, currentDate.month + 1, i));
    }

    return calendarDays;
  }

  // فحص إذا كان التاريخين في نفس اليوم
  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  // فحص ما إذا كان التاريخ يقع ضمن النطاق
  bool isDateInRange(DateTime date, DateTime start, DateTime end) {
    return date.compareTo(DateTime(start.year, start.month, start.day)) >= 0 &&
        date.compareTo(DateTime(end.year, end.month, end.day)) <= 0;
  }
}

// مساعد لتحديد موقع الأحداث متعددة الأيام
class MultidayEventPosition {
  final MainCalendarEventData event;
  final int startIndex;
  final int endIndex;

  MultidayEventPosition({
    required this.event,
    required this.startIndex,
    required this.endIndex,
  });
}
