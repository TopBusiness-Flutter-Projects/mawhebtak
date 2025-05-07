
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:mawhebtak/features/events/screens/widgets/custom_apply_app_bar.dart';
import 'package:mawhebtak/core/utils/custom_pick_media.dart';
import '../../../core/exports.dart';
import '../../home/screens/widgets/follow_button.dart';
import '../cubit/event_cubit.dart';

class ApplyForEvent extends StatefulWidget {
  const ApplyForEvent({super.key});

  @override
  State<ApplyForEvent> createState() => _ApplyForEventState();
}

class _ApplyForEventState extends State<ApplyForEvent> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<EventCubit>();

    return BlocBuilder<EventCubit, EventState>(
      builder: (BuildContext context, state) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBarWithClearWidget(
                    title: "apply_for_event".tr(),
                  ),
                  SizedBox(height: getHeightSize(context) / 33),
                  const CustomPickMediaWidget(),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 3.h),
                    child: Text(
                      'expected_fees'.tr(),
                      style: getMediumStyle(
                          fontSize: 14.sp, color: AppColors.darkGray),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 21.0.w),
                    child: DropdownTextFieldWidget(
                     isWithCurrency: true,
                      currencyList: const ["L.E","USA"],
                      dataLists: const ["Example@mail.com","Example@mail.com"], hintText: 'Example@mail.com',),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 3.h),
                    child: Text(
                      'event_req'.tr(),
                      style: getMediumStyle(
                          fontSize: 14.sp, color: AppColors.darkGray),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.0.w, vertical: 10.h),
                    child:   DropdownTextFieldWidget(

                      dataLists: const ["Teacher","Singer"], hintText: '',),

                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 3.h),
                    child: Text(
                      'specify_needs'.tr(),
                      style: getMediumStyle(
                          fontSize: 14.sp, color: AppColors.darkGray),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 21.0.w),
                    child: CustomTextField(
                      hintText: "description_here".tr(),
                      isMessage: true,
                    ),
                  ),
                  Center(
                    child: CustomContainerButton(
                      title: "apply".tr(),
                      color: AppColors.primary,
                      width: 327.w,
                      height: 48.h,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _label(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.h, top: 16.h),
    child: Text(
      text,
      style: TextStyle(
        color: AppColors.blackLite,
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
      ),
    ),
  );
}
