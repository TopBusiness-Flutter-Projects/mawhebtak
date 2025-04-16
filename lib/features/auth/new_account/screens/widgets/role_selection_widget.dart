import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/exports.dart';



class RoleSelectionWidget extends StatefulWidget {
  const RoleSelectionWidget({super.key});

  @override
  _RoleSelectionWidgetState createState() => _RoleSelectionWidgetState();
}

class _RoleSelectionWidgetState extends State<RoleSelectionWidget> {
  int selectedIndex = 0;

  final List<String> roles = ["Talent", "Talent Seeker", "Audience"];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "i_am".tr(),
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 50.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: roles.length,
            itemBuilder: (context, index) {
              bool isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10.w),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: isSelected ? AppColors.primary : Colors.grey[200],
                    border: Border.all(
                      color: isSelected ? AppColors.primary : Colors.transparent,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    roles[index],
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: isSelected ? AppColors.white : Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
