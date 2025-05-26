import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/exports.dart';
import '../../../../events/screens/widgets/custom_row_event.dart';
import 'custom_row_section.dart';
import 'experince_widget.dart';

class AboutWidget extends StatelessWidget {
  const AboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            CustomRowSection(
              title: "bio".tr(),
            ),
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0.w, right: 16.w),
              child: Text(
                "Mawahbtak big platform connects all artists in all fields to make large community bettwen artists in Egypt Mawahbtak big platform connects all artists in all fields to make large community bettwen artists in Egypt.",
                style: getRegularStyle(
                    fontSize: 13.sp, color: AppColors.grayMedium),
              ),
            ),
          ],
        ),
        Container(
            height: 8.h, color: AppColors.grayLite, width: double.infinity),
        SizedBox(
          height: 10.h,
        ),
        CustomRowSection(title: "personal_info".tr()),
        CustomRowEvent(text: 'email'.tr(), text2: 'Egypt, Cairo'),
        CustomRowEvent(
            text: 'phone'.tr(), text2: 'Egypt, Cairo', isSecond: true),
        CustomRowEvent(text: 'age'.tr(), text2: 'Egypt, Cairo'),
        CustomRowEvent(
            text: 'location'.tr(), text2: 'Egypt, Cairo', isSecond: true),
        CustomRowEvent(text: 'syndicate'.tr(), text2: '1772426664'),
        Container(
            height: 8.h, color: AppColors.grayLite, width: double.infinity),
        SizedBox(
          height: 10.h,
        ),
        CustomRowSection(title: "experience".tr()),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return ExperinceWidget();
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 5.h,
            );
          },
        )
      ],
    );
  }
}
