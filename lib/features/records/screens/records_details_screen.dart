import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/widgets/custom_simple_appbar.dart';
import 'package:mawhebtak/features/records/cubit/records_cubit.dart';
import 'package:mawhebtak/features/records/cubit/records_state.dart';

import '../../../core/exports.dart';

class RecordsDetailsScreen extends StatefulWidget {
  const RecordsDetailsScreen({super.key});

  @override
  State<RecordsDetailsScreen> createState() => _RecordsDetailsScreenState();
}

class _RecordsDetailsScreenState extends State<RecordsDetailsScreen> {
  @override


  Widget build(BuildContext context) {
    var cubit = context.read<RecordsCubit>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent, // الشفافية
        statusBarIconBrightness: Brightness.light, // لون الأيقونات (أبيض)
      ),
      child: Scaffold(
        body: Stack(
          children: [

            Column(
              children: [
                10.h.verticalSpace,
                CustomSimpleAppbar(title: "records".tr()),
                BlocBuilder<RecordsCubit,RecordsState>(
                  builder: (context,state) {
                    return Expanded(
                      child: Container(
                        decoration: BoxDecoration(color: AppColors.grayLite),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                          ],
                        ),
                      ),
                    );
                  }
                )
              ],
            ),
            Positioned(
              bottom: 50.h,
              right: 20.w,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.addNewRecordRoute);
                },
                child: Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
