import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:mawhebtak/core/widgets/custom_container_with_shadow.dart';
import 'package:mawhebtak/features/events/cubit/event_cubit.dart';
import 'package:mawhebtak/features/events/screens/widgets/custom_event_details_widget.dart';
import 'package:mawhebtak/features/events/screens/widgets/event_details_body.dart';
import 'package:mawhebtak/features/events/screens/widgets/toggle_tabs.dart';

import '../../../core/exports.dart';
import '../../home/screens/widgets/follow_button.dart';

class SecondDetailsEventScreen extends StatelessWidget {
  const SecondDetailsEventScreen({super.key});

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
              //backgroundColor: AppColors.grayDark,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomEventDetailsWidget(
                      isSecondEventDetails: true,
                    ),
                    //toogle
                    SizedBox(
                      height: getHeightSize(context) / 55,
                    ),
                    const ToggleTabs(),
                    if (cubit.selectedIndex == 0) ...[
                      const EventDetailsBody()
                    ] else ...[
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.all(10.0.w),
                            child: CustomContainerWithShadow(
                              reduis: 8.r,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 40.h,
                                          width: 40.w,
                                          child: Image.asset(
                                              ImageAssets.profileImage),
                                        ),
                                        SizedBox(width: 8.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText("Ahmed Mokhtar",
                                                style: getMediumStyle(
                                                    fontSize: 16.sp)),
                                            AutoSizeText(
                                              "Talent / Actor Expert",
                                              style: getRegularStyle(
                                                  fontSize: 14.sp,
                                                  color: AppColors.grayLight),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    CustomContainerButton(
                                      title: "message",
                                      borderColor: AppColors.primary,
                                      textColor: AppColors.primary,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 10.h,
                          );
                        },
                      )
                    ]
                  ],
                ),
              ),
            ));
      },
    );
  }
}
