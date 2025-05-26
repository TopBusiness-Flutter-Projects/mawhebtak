import 'package:easy_localization/easy_localization.dart';

import 'package:mawhebtak/core/exports.dart';

import '../../data/model/event_details_model.dart';

class StaticsCards extends StatelessWidget {
  const StaticsCards({super.key, this.item});
  final GetMainEvenDetailsModelData? item;
  @override
  Widget build(BuildContext context) {
    return ((item?.enrolled == null && item?.revenu == null) ||
            (item?.enrolled == 0 && item?.revenu == 0))
        ? Container()
        : Row(
            children: [
              // First card: Enrolled
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                    color:
                        const Color(0xFFF7F7F7), // نفس الخلفية الرمادية الفاتحة
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item?.enrolled.toString() ?? '0',
                        style: getMediumStyle(
                          color: AppColors.primary,
                          fontSize: 21.sp,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('enrolled'.tr(),
                          style: getMediumStyle(
                              fontSize: 14.sp, color: AppColors.grayDark)),
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
                        item?.revenu.toString() ?? '0',
                        style: getMediumStyle(
                          color: AppColors.green,
                          fontSize: 21.sp,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('revenu'.tr(),
                          style: getMediumStyle(
                              fontSize: 14.sp, color: AppColors.grayDark)),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
