import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/features/events/cubit/event_cubit.dart';

import '../../../../../core/exports.dart';

import '../../../../core/widgets/custom_container_with_shadow.dart';
import '../../../../core/widgets/full_screen_video_view.dart';
import '../../../home/screens/widgets/follow_button.dart';
import '../../data/model/event_details_model.dart';
import 'custom_row_event.dart';

class RequireEventUser extends StatelessWidget {
  const RequireEventUser({super.key, this.user});

  final EventRequest? user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        var cubit = context.read<EventCubit>();
        return Padding(
          padding: EdgeInsets.all(10.0.w),
          child: CustomContainerWithShadow(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.grayLite2,
                      blurRadius: 5.r,
                      offset: Offset(0, 2.h), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.r)),
              child: Column(
                children: [
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     SizedBox(
                  //       height: 40.h,
                  //       width: 40.w,
                  //       child: CircleAvatar(
                  //         backgroundImage: NetworkImage(
                  //           user?.user?.image ?? '',
                  //         ),
                  //         backgroundColor: AppColors.primary,
                  //       ),
                  //     ),
                  //     SizedBox(width: 8.w),
                  //     Expanded(
                  //       child: Row(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Flexible(
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 AutoSizeText(user?.user?.name ?? '',
                  //                     maxLines: 2,
                  //                     style: getMediumStyle(fontSize: 18.sp)),
                  //                 if (user?.user?.headline != null)
                  //                   AutoSizeText(
                  //                     user?.user?.headline.toString() ?? '',
                  //                     maxLines: 2,
                  //                     style: getRegularStyle(
                  //                         fontSize: 16.sp,
                  //                         color: AppColors.grayLight),
                  //                   ),
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     CustomContainerButton(
                  //       title: "message",
                  //       onTap: () {
                  //         log('Message Button Nav To > Chat Screen');
                  //       },
                  //       borderColor: AppColors.primary,
                  //       textColor: AppColors.primary,
                  //     )
                  //   ],
                  // ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 40.h,
                              width: 40.w,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  user?.user?.image ?? '',
                                ),
                                backgroundColor: AppColors.primary,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(user?.user?.name ?? "",
                                      style: getMediumStyle(fontSize: 16.sp)),
                                  if (user?.user?.headline != null)
                                    AutoSizeText(
                                      user?.user?.headline.toString() ?? "",
                                      style: getRegularStyle(
                                          fontSize: 14.sp,
                                          color: AppColors.grayLight),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomContainerButton(
                        title: "message",
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 5.h),
                        onTap: () {
                          log('Message Button Nav To > Chat Screen');
                        },
                        borderColor: AppColors.primary,
                        textColor: AppColors.primary,
                      )
                    ],
                  ),
                  5.h.verticalSpace,
                  CustomRowEvent(
                    text: 'status'.tr(),
                    text2: user?.status ?? '',
                    isSecond: true,
                  ),
                  5.h.verticalSpace,
                  CustomRowEvent(
                    text: 'note'.tr(),
                    text2: user?.note ?? '',
                    isSecond: true,
                  ),
                  5.h.verticalSpace,
                  CustomRowEvent(
                    text: 'expected_fees'.tr(),
                    text2: user?.price ?? '',
                    isSecond: true,
                  ),
                  5.h.verticalSpace,
                  CustomRowEvent(
                    text: 'event_requirement'.tr(),
                    text2: user?.eventRequirement ?? '',
                    isSecond: true,
                  ),
                  5.h.verticalSpace,

                  //! show media
                  if (user!.media!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'media'.tr(),
                            style: getMediumStyle(),
                          ),
                        ),
                        SizedBox(
                            height: 100.h,
                            width: double.infinity,
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(children: [
                                  ...user?.media?.map((media) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    FullScreenViewer(
                                                        filePath:
                                                            media.file ?? '',
                                                        fileType:
                                                            media.extension ??
                                                                ''),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 100.w,
                                            margin: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image:
                                                    media.extension == 'video'
                                                        ? const AssetImage(
                                                                ImageAssets
                                                                    .videoImage)
                                                            as ImageProvider
                                                        : NetworkImage(
                                                            media.file ?? ''),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList() ??
                                      []
                                ]))),
                      ],
                    ),
                  5.h.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                    child: user?.status != 'pending'
                        ? Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 5.h),
                            decoration: BoxDecoration(
                              color: user?.status == 'rejected'
                                  ? AppColors.redLight2
                                  : AppColors.secondPrimary,
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              user?.status ?? '',
                              style: getMediumStyle(color: AppColors.white),
                            ),
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomContainerButton(
                                  title: 'accept'.tr(),
                                  onTap: () {
                                    cubit.actionEventRequest(
                                        cubit.eventDetails?.data?.id
                                                ?.toString() ??
                                            '',
                                        'accepted',
                                        user?.id?.toString() ?? '',
                                        context);
                                    // Handle accept action
                                  },
                                  color: AppColors.primary,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomContainerButton(
                                  title: 'reject'.tr(),
                                  onTap: () {
                                    cubit.actionEventRequest(
                                        cubit.eventDetails?.data?.id
                                                ?.toString() ??
                                            '',
                                        'rejected',
                                        user?.id?.toString() ?? '',
                                        context);
                                    // Handle reject action
                                  },
                                  color: AppColors.transparent,
                                  borderColor: AppColors.red,
                                  textColor: AppColors.red,
                                ),
                              ),
                            ],
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
