import 'package:easy_localization/easy_localization.dart';

import '../../../../core/exports.dart';

class CustomRow extends StatelessWidget {
  CustomRow({super.key, required this.text, this.onTap});
  String text;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text.tr(),
            style: getMediumStyle(
              fontSize: 18.sp,
              color: AppColors.white,
            ),
          ),
          InkWell(
              onTap: onTap,
              child: Text(
                "see_all".tr(),
                style: getUnderLine(fontSize: 16.sp, color: AppColors.lbny),
              )),
        ],
      ),
    );
  }
}
