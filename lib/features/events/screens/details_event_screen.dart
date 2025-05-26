import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/events/screens/widgets/custom_apply_button.dart';
import 'package:mawhebtak/features/events/screens/widgets/custom_event_details_widget.dart';
import 'package:mawhebtak/features/events/screens/widgets/custom_row_event.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/exports.dart';
import '../../../core/widgets/custom_container_with_shadow.dart';
import '../../home/screens/widgets/follow_button.dart';
import '../cubit/event_cubit.dart';
import 'widgets/event_details_body.dart';
import 'widgets/toggle_tabs.dart';

class DetailsEventScreen extends StatefulWidget {
  const DetailsEventScreen({super.key, this.eventId});
  final String? eventId;

  @override
  State<DetailsEventScreen> createState() => _DetailsEventScreenState();
}

class _DetailsEventScreenState extends State<DetailsEventScreen> {
  @override
  void initState() {
    context
        .read<EventCubit>()
        .getEventDetailsById(widget.eventId ?? "", context);
    // إذا كنت تريد الحصول على تفاصيل الحدث عند تحميل الشاشة
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, EventState>(
      builder: (BuildContext context, state) {
        var cubit = context.read<EventCubit>();
        return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
            ),
            child: Scaffold(
              //backgroundColor: AppColors.grayDark,
              body: state is GetEventDetailsLoadingState
                  ? const Center(
                      child: CustomLoadingIndicator(),
                    )
                  : state is GetEventDetailsErrorState
                      ? Center(
                          child: InkWell(
                          onTap: () {
                            cubit.getEventDetailsById(
                                widget.eventId.toString(), context);
                          },
                          child: Text("retry".tr()),
                        ))
                      : SingleChildScrollView(
                          child: cubit.eventDetails?.data?.isFollowed == true
                              ? Column(
                                  children: [
                                    CustomEventDetailsWidget(
                                      item: cubit.eventDetails?.data,
                                      isFollowed:
                                          cubit.eventDetails?.data?.isFollowed,
                                      mediaList:
                                          cubit.eventDetails?.data?.media ?? [],
                                    ),
                                    EventDetailsBody(
                                      item: cubit.eventDetails?.data,
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomEventDetailsWidget(
                                      item: cubit.eventDetails?.data,
                                      isFollowed:
                                          cubit.eventDetails?.data?.isFollowed,
                                      mediaList:
                                          cubit.eventDetails?.data?.media ?? [],
                                    ),
                                    //toogle
                                    SizedBox(
                                      height: getHeightSize(context) / 55,
                                    ),
                                    const ToggleTabs(),
                                    if (cubit.selectedIndex == 0) ...[
                                      EventDetailsBody(
                                        item: cubit.eventDetails?.data,
                                      ),
                                    ] else if (cubit.selectedIndex == 1) ...[
                                      ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: 10,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: EdgeInsets.all(10.0.w),
                                            child: CustomContainerWithShadow(
                                              reduis: 8.r,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 40.h,
                                                          width: 40.w,
                                                          child: Image.asset(
                                                              ImageAssets
                                                                  .profileImage),
                                                        ),
                                                        SizedBox(width: 8.w),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            AutoSizeText(
                                                                "Ahmed Mokhtar",
                                                                style: getMediumStyle(
                                                                    fontSize:
                                                                        16.sp)),
                                                            AutoSizeText(
                                                              "Talent / Actor Expert",
                                                              style: getRegularStyle(
                                                                  fontSize:
                                                                      14.sp,
                                                                  color: AppColors
                                                                      .grayLight),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    CustomContainerButton(
                                                      title: "message",
                                                      borderColor:
                                                          AppColors.primary,
                                                      textColor:
                                                          AppColors.primary,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return SizedBox(
                                            height: 10.h,
                                          );
                                        },
                                      )
                                    ] else
                                      ...[]
                                  ],
                                ),
                        ),
            ));
      },
    );
  }
}
