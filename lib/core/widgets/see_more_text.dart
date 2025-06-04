// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/gestures.dart';

import '../exports.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  final double? fontSize;
  const ExpandableTextWidget({
    Key? key,
    required this.text,
    this.fontSize,
  }) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool _isExpanded = false;

  /// Detects if the first character is Arabic
  /// Checks if a string contains Arabic or English characters.
  ///
  /// - [text]: The input string to check.
  /// - Returns `true` if Arabic or English is detected, `false` otherwise.
  bool isFirstCharArabic(String text) {
    if (text.isEmpty) return false; // Handle empty string

    // Arabic Unicode ranges: \u0600-\u06FF, \u0750-\u077F, \u08A0-\u08FF
    final arabicRegex = RegExp(r'^[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]');

    return arabicRegex.hasMatch(text[0]);
  }

  @override
  Widget build(BuildContext context) {
    const int maxLengthBeforeEllipsis = 180;
    final bool isArabic = isFirstCharArabic(widget.text);
    log('00 $isArabic ${widget.text}');
    final String visibleText =
        widget.text.length > maxLengthBeforeEllipsis && !_isExpanded
            ? '${widget.text.substring(0, maxLengthBeforeEllipsis)}... '
            : widget.text;
//MARK: DONE
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: isArabic ? 0 : 10.w,
        right: isArabic ? 10.w : 0,
      ),
      child: Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: RichText(
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
          text: TextSpan(
            text: visibleText,
            style: getRegularStyle(
              fontSize: widget.fontSize ?? 18.sp,
              color: AppColors.blackLite,
            ),
            children: <TextSpan>[
              if (widget.text.length > maxLengthBeforeEllipsis)
                TextSpan(
                  text: ' ${_isExpanded ? 'see_less'.tr() : 'see_more'.tr()} ',
                  style: TextStyle(fontSize: 16.sp, color: AppColors.gray),
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
      ),
    );
  }
}
