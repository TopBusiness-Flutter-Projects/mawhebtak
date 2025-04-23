import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/core/exports.dart';

String getCurrentFormattedDate() {
  final now = DateTime.now();
  return "${now.day}/${now.month}/${now.year}";
}

class DatePickerField extends StatelessWidget {
  final Function()? onTab;
  final DateTime? selectedDate;
  final String title;
  final bool isWithTime;
  const DatePickerField({
    super.key,
    this.onTab,
    this.selectedDate,
    this.isWithTime = false,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    String formatDate(DateTime dateTime) {
      final formatter = DateFormat('d MMMM y \'at\' hh:mm a', 'en');
      return formatter.format(dateTime);
    }
    DateTime now = DateTime(2022, 6, 16, 2, 0); // مثال ثابت

    final formatted = formatDate(now);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.0.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.sp,
          ),
          Text(
            title,
            style: getRegularStyle(fontSize: 14.sp),
          ),
          SizedBox(
            height: 10.sp,
          ),
          GestureDetector(
            onTap: onTab,
            child: Container(
              decoration: BoxDecoration(
            //    border: Border.all(color: Colors.grey),
                color: AppColors.grayLite,
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedDate != null
                        ? isWithTime
                            ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}\n${selectedDate!.hour}:${selectedDate!.minute}'
                            : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                        : formatDate(now),
                    style: TextStyle(fontSize: 16.sp),
                  ),
                   SvgPicture.asset(ImageAssets.calendarBold),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
