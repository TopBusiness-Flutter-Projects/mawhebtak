import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawhebtak/core/exports.dart';

class StaticsCards extends StatelessWidget {
  const StaticsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // First card: Enrolled
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7), // نفس الخلفية الرمادية الفاتحة
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '200 L.E',
                  style: getMediumStyle(
                    color: AppColors.primary,
                    fontSize: 21.sp,
                  ),
                ),
                const SizedBox(height: 8),
                 Text(
                  'enrolled'.tr(),
                  style:getMediumStyle(fontSize: 14.sp,color: AppColors.grayDark)
                ),
              ],
            ),
          ),
        ),

        // Second card: Revenue
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '5000 L.E',
                  style: getMediumStyle(
                    color: AppColors.green,
                    fontSize: 21.sp,
                  ),
                ),
                const SizedBox(height: 8),
                 Text(
                  'revenu'.tr(),
                     style:getMediumStyle(fontSize: 14.sp,color: AppColors.grayDark)
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
