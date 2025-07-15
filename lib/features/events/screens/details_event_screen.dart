import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/events/screens/widgets/custom_event_details_widget.dart';
import 'package:mawhebtak/features/profile/cubit/profile_cubit.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/exports.dart';
import '../../../core/notification_services/notification_service.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/utils/check_login.dart';
import '../../../core/widgets/custom_container_with_shadow.dart';
import '../../chat/screens/message_screen.dart';
import '../../home/screens/widgets/follow_button.dart';
import '../cubit/event_cubit.dart';
import 'widgets/event_details_body.dart';
import 'widgets/requires_event_user.dart';
import 'widgets/toggle_tabs.dart';

class DeepLinkDataModel {
  String id;
  bool isDeepLink;
  DeepLinkDataModel({
    required this.id,
    required this.isDeepLink,
  });
}

class DetailsEventScreen extends StatefulWidget {
  const DetailsEventScreen({super.key, this.eventDataModel});
  final DeepLinkDataModel? eventDataModel;

  @override
  State<DetailsEventScreen> createState() => _DetailsEventScreenState();
}

class _DetailsEventScreenState extends State<DetailsEventScreen> {
  @override
  void initState() {
    context
        .read<EventCubit>()
        .getEventDetailsById(widget.eventDataModel?.id ?? "", context);
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
            child: WillPopScope(
              onWillPop: () async {
                if (isWithNotification == true ||
                    widget.eventDataModel?.isDeepLink == true) {
                  isWithNotification = false;
                  Navigator.pushReplacementNamed(context, Routes.mainRoute);
                } else {
                  Navigator.pop(context);
                }

                return false;
              },
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
                                  widget.eventDataModel?.id.toString() ?? '',
                                  context);
                            },
                            child: Text(
                              "retry".tr(),
                            ),
                          ))
                        : SingleChildScrollView(
                            child: (cubit.eventDetails?.data?.isFollowed ==
                                        false &&
                                    cubit.eventDetails?.data?.isMine == false)
                                ? Column(
                                    children: [
                                      CustomEventDetailsWidget(
                                        isDeepLink:
                                            widget.eventDataModel?.isDeepLink ??
                                                false,
                                        onTap: () async {
                                          final user = await Preferences
                                              .instance
                                              .getUserModel();
                                          if (user.data?.token == null) {
                                            checkLogin(context);
                                          } else {
                                            (cubit.eventDetails?.data?.isFree == 0)?
                                            showDialog(
                                              context: context,
                                              builder: (_) => Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                insetPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 30.w,
                                                        vertical: 24.h),
                                                child: Padding(
                                                  padding: EdgeInsets.all(20.w),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: GestureDetector(
                                                          onTap: () =>
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(),
                                                          child: Icon(
                                                              Icons.close,
                                                              color: Colors.grey
                                                                  .shade600,
                                                              size: 24.sp),
                                                        ),
                                                      ),
                                                      SizedBox(height: 8.h),
                                                      Icon(Icons.info_outline,
                                                          color:
                                                              AppColors.primary,
                                                          size: 48.sp),
                                                      SizedBox(height: 16.h),
                                                      Text(
                                                        'booking_method'
                                                            .tr(),
                                                        textAlign:
                                                        TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          fontWeight: FontWeight.w700,
                                                          color: AppColors.primary,
                                                        ),
                                                      ),
                                                      SizedBox(height: 24.h),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                cubit
                                                                    .followUnfollowEvent(
                                                                  context:
                                                                      context,
                                                                  id: cubit
                                                                          .eventDetails
                                                                          ?.data
                                                                          ?.id
                                                                          ?.toString() ??
                                                                      '',
                                                                  paymentMethod:
                                                                      0,
                                                                );
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .primary,
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            12.h),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                'pay_now'.tr(),
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 12.w),
                                                          Expanded(
                                                            child: TextButton(
                                                              onPressed: () {
                                                                cubit
                                                                    .followUnfollowEvent(
                                                                  context:
                                                                      context,
                                                                  id: cubit
                                                                          .eventDetails
                                                                          ?.data
                                                                          ?.id
                                                                          ?.toString() ??
                                                                      '',
                                                                  paymentMethod:
                                                                      1,
                                                                );
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              style: TextButton
                                                                  .styleFrom(
                                                                foregroundColor:
                                                                    AppColors
                                                                        .primary,
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            12.h),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  side: BorderSide(
                                                                      color: AppColors
                                                                          .primary),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                  'pay_later'
                                                                      .tr()),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ): cubit
                                              .followUnfollowEvent(
                                          context:
                                          context,
                                          id: cubit
                                              .eventDetails
                                              ?.data
                                              ?.id
                                              ?.toString() ??
                                          '',
                                          paymentMethod:
                                          1,
                                          );

                                          }
                                        },
                                        item: cubit.eventDetails?.data,
                                        isFollowed: cubit
                                            .eventDetails?.data?.isFollowed,
                                        mediaList:
                                            cubit.eventDetails?.data?.media ??
                                                [],
                                      ),
                                      EventDetailsBody(
                                          mainDeepLink: widget.eventDataModel,
                                          item: cubit.eventDetails?.data),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomEventDetailsWidget(
                                        isDeepLink:
                                            widget.eventDataModel?.isDeepLink ??
                                                false,
                                        onTap: () async {
                                          final user = await Preferences
                                              .instance
                                              .getUserModel();
                                          if (user.data?.token == null) {
                                            checkLogin(context);
                                          } else {
                                            cubit.followUnfollowEvent(
                                              context: context,
                                              id: cubit.eventDetails?.data?.id
                                                      ?.toString() ??
                                                  '',
                                              paymentMethod: 1,
                                            );
                                          }
                                        },
                                        item: cubit.eventDetails?.data,
                                        isFollowed: cubit
                                            .eventDetails?.data?.isFollowed,
                                        mediaList:
                                            cubit.eventDetails?.data?.media ??
                                                [],
                                      ),
                                      SizedBox(
                                        height: getHeightSize(context) / 55,
                                      ),
                                      const ToggleTabs(),
                                      if (cubit.selectedIndex == 0) ...[
                                        EventDetailsBody(
                                          mainDeepLink: widget.eventDataModel,
                                          item: cubit.eventDetails?.data,
                                        ),
                                      ] else if (cubit.selectedIndex == 1) ...[
                                        cubit.eventDetails?.data?.enrolledUsers
                                                    ?.length ==
                                                0
                                            ? Center(
                                                child: Text('no_users'.tr()),
                                              )
                                            : ListView.separated(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: cubit
                                                        .eventDetails
                                                        ?.data
                                                        ?.enrolledUsers
                                                        ?.length ??
                                                    0,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  var enrolledUser = cubit
                                                      .eventDetails
                                                      ?.data
                                                      ?.enrolledUsers?[index];
                                                  return Padding(
                                                    padding:
                                                        EdgeInsets.all(10.0.w),
                                                    child:
                                                        CustomContainerWithShadow(
                                                      reduis: 8.r,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Flexible(
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SizedBox(
                                                                    height:
                                                                        40.h,
                                                                    width: 40.w,
                                                                    child:
                                                                        CircleAvatar(
                                                                      backgroundImage:
                                                                          NetworkImage(
                                                                        enrolledUser?.image ??
                                                                            '',
                                                                      ),
                                                                      backgroundColor:
                                                                          AppColors
                                                                              .primary,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width:
                                                                          8.w),
                                                                  Flexible(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        AutoSizeText(
                                                                            enrolledUser?.name ??
                                                                                "",
                                                                            style:
                                                                                getMediumStyle(fontSize: 16.sp)),
                                                                        if (enrolledUser?.headline !=
                                                                            null)
                                                                          AutoSizeText(
                                                                            enrolledUser?.headline.toString() ??
                                                                                "",
                                                                            style:
                                                                                getRegularStyle(fontSize: 14.sp, color: AppColors.grayLight),
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            if (cubit
                                                                        .eventDetails
                                                                        ?.data
                                                                        ?.isMine ==
                                                                    false ||
                                                                (context
                                                                        .read<
                                                                            ProfileCubit>()
                                                                        .user
                                                                        ?.data
                                                                        ?.id
                                                                        ?.toString() !=
                                                                    enrolledUser
                                                                        ?.id
                                                                        ?.toString()))
                                                              CustomContainerButton(
                                                                title:
                                                                    "message",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 18.sp,
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal: 15
                                                                            .w,
                                                                        vertical:
                                                                            5.h),
                                                                onTap:
                                                                    () async {
                                                                  final user =
                                                                      await Preferences
                                                                          .instance
                                                                          .getUserModel();

                                                                  Navigator.pushNamed(
                                                                      context,
                                                                      Routes
                                                                          .messageRoute,
                                                                      arguments: MainUserAndRoomChatModel(
                                                                          receiverId: enrolledUser
                                                                              ?.id
                                                                              ?.toString(),
                                                                          chatName:
                                                                              enrolledUser?.name ?? ''));

                                                                  log('Message Button Nav To > Chat Screen');
                                                                },
                                                                borderColor:
                                                                    AppColors
                                                                        .primary,
                                                                textColor:
                                                                    AppColors
                                                                        .primary,
                                                              )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                separatorBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return SizedBox(
                                                    height: 10.h,
                                                  );
                                                },
                                              )
                                      ] else if (cubit
                                              .eventDetails?.data?.isMine ==
                                          true) ...[
                                        cubit.eventDetails?.data?.eventRequests
                                                    ?.length ==
                                                0
                                            ? Center(
                                                child: Text('no_requsts'.tr()),
                                              )
                                            : ListView.separated(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return RequireEventUser(
                                                    user: cubit
                                                        .eventDetails
                                                        ?.data
                                                        ?.eventRequests?[index],
                                                  );
                                                },
                                                separatorBuilder:
                                                    (context, index) =>
                                                        SizedBox(height: 10.h),
                                                itemCount: cubit
                                                        .eventDetails
                                                        ?.data
                                                        ?.eventRequests
                                                        ?.length ??
                                                    0)
                                      ] else
                                        const SizedBox(),
                                    ],
                                  ),
                          ),
              ),
            ));
      },
    );
  }
}
