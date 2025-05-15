import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';

import '../exports.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({super.key, required this.text});

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // هنا هنحسب عدد الحروف اللي تعادل سطر ونص (تقدير تقريبي)
    const int maxLengthBeforeEllipsis = 60;

    final String visibleText =
        widget.text.length > maxLengthBeforeEllipsis && !_isExpanded
            ? '${widget.text.substring(0, maxLengthBeforeEllipsis)}... '
            : widget.text;

    return Padding(
      padding: EdgeInsets.only(left: 10.0.w),
      child: RichText(
        text: TextSpan(
          text: visibleText,
          style: getRegularStyle(
            fontSize: 15.sp,
            color: AppColors.blackLite,
          ),
          children: <TextSpan>[
            if (widget.text.length > maxLengthBeforeEllipsis)
              TextSpan(
                text: _isExpanded ? 'see_less'.tr() : 'see_more'.tr(),
                style:TextStyle(
                fontSize: 14.sp,
                color: AppColors.gray
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
              ),
          ],
        ),
      ),
    );
  }
}
