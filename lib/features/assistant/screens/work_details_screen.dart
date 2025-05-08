import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/preferences/hive/models/work_model.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_cubit.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_state.dart';
import '../../../core/exports.dart';
class WorkDetailsScreen extends StatefulWidget {
  const WorkDetailsScreen({super.key, this.work});
  final WorkModel? work;

  @override
  State<WorkDetailsScreen> createState() => _WorkDetailsScreenState();
}

class _WorkDetailsScreenState extends State<WorkDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AssistantCubit>().getAllAssistantFromWork(widget.work?.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                10.h.verticalSpace,
                CustomSimpleAppbar(title: "assistant".tr()),
                BlocBuilder<AssistantCubit, AssistantState>(
                  builder: (context, state) {
                    final cubit = context.read<AssistantCubit>();



                    return Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.grayLite
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            10.h.verticalSpace,
                            Padding(
                              padding:  EdgeInsets.only(left: 20.w,right: 20.w , bottom: 10.h , top: 10.h),
                              child: Text("my_work".tr(),style: TextStyle(
                                color: AppColors.blackLite,
                                fontSize: 14.sp
                              ),),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: Container(
                                decoration: BoxDecoration(color: AppColors.white),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.h, horizontal: 20.w),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(AppIcons.bagIcon),
                                      10.w.horizontalSpace,
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.white
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.work?.title ?? "",
                                                style: getMediumStyle(fontSize: 14.sp),
                                              ),
                                              10.h.verticalSpace,
                                              Text(
                                                "${widget.work?.assistants?.length ?? 0} Racors",
                                                style: getMediumStyle(
                                                  fontSize: 13.sp,
                                                  color: AppColors.secondPrimary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                                            // if (cubit.assistants == null || cubit.assistants!.isEmpty) {
                                            // return Expanded(
                                            // child: Center(
                                            // child: Text(
                                            // "no_assistant_found".tr(),
                                            // style: getRegularStyle(
                                            // fontSize: 18.sp, color: AppColors.blackLite),
                                            // ),
                                            // ),
                                            // );
                                            // },
                            // Expanded(
                            //   child: ListView.builder(
                            //     controller: cubit.scrollController,
                            //     padding: EdgeInsets.symmetric(
                            //         horizontal: 16.w, vertical: 10.h),
                            //     itemCount: cubit.assistants!.length,
                            //     itemBuilder: (context, index) {
                            //       final assistant = cubit.assistants![index];
                            //       return Container(
                            //         margin: EdgeInsets.only(bottom: 12.h),
                            //         padding: EdgeInsets.all(12.w),
                            //         decoration: BoxDecoration(
                            //           color: Colors.white,
                            //           borderRadius: BorderRadius.circular(12.r),
                            //           boxShadow: const [
                            //             BoxShadow(
                            //               color: Colors.black12,
                            //               blurRadius: 5,
                            //               offset: Offset(0, 2),
                            //             ),
                            //           ],
                            //         ),
                            //         child: Column(
                            //           crossAxisAlignment: CrossAxisAlignment.start,
                            //           children: [
                            //             Text(
                            //               assistant.title ?? "",
                            //               style: getBoldStyle(
                            //                   fontSize: 16.sp,
                            //                   color: AppColors.primary),
                            //             ),
                            //             8.h.verticalSpace,
                            //             Text(
                            //               assistant.description ?? "",
                            //               style: getRegularStyle(fontSize: 14.sp),
                            //             ),
                            //             8.h.verticalSpace,
                            //             Row(
                            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //               children: [
                            //                 Text(
                            //                   assistant.date != null
                            //                       ? DateFormat('d MMMM, yyyy')
                            //                       .format(assistant.date!)
                            //                       : '',
                            //                   style: getRegularStyle(
                            //                       fontSize: 12.sp, color: Colors.grey),
                            //                 ),
                            //                 GestureDetector(
                            //                   onTap: () {
                            //                     // TODO: Handle reminder setup
                            //                   },
                            //                   child: Row(
                            //                     children: [
                            //                       Icon(
                            //                         Icons.notifications,
                            //                         color: assistant.remindedTime != null
                            //                             ? Colors.red
                            //                             : Colors.grey,
                            //                         size: 18,
                            //                       ),
                            //                       4.w.horizontalSpace,
                            //                       Text(
                            //                         assistant.remindedTime != null
                            //                             ? "Set Assistant (${assistant.remindedTime!.isUtc}:00)"
                            //                             : "Set Assistant",
                            //                         style: getRegularStyle(
                            //                           fontSize: 12.sp,
                            //                           color: assistant.remindedTime != null
                            //                               ? Colors.red
                            //                               : Colors.grey,
                            //                         ),
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ],
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),
                            20.h.verticalSpace,
                            Expanded(child: AssistantsList()),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            Positioned(
              bottom: 50.h,
              right: 20.w,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.addAssistantRoute,arguments: widget.work);
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
class AssistantsList extends StatelessWidget {
  AssistantsList({Key? key}) : super(key: key);
  //
  // final List<AssistantItem> reminders = [
  //   AssistantItem(
  //     title: 'Scene 10 Football Match',
  //     details: [
  //       'The T-shirt should be number 10',
  //       'Captin should have a cap',
  //       'I have a dange in my leg',
  //     ],
  //     date: '10 March, 2022',
  //     isActive: true,
  //     reminderTime: '30:00',
  //   ),
  //   AssistantItem(
  //     title: 'Scene 10 Football Match',
  //     details: [
  //       'The T-shirt should be number 10',
  //       'Captin should have a cap',
  //       'I have a dange in my leg',
  //     ],
  //     date: '10 March, 2022',
  //     isActive: false,
  //   ),
  //   AssistantItem(
  //     title: 'Scene 10 Football Match',
  //     details: [
  //       'The T-shirt should be number 10',
  //       'Captin should have a cap',
  //       'I have a dange in my leg',
  //     ],
  //     date: '10 March, 2022',
  //     isActive: false,
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    var assistants =  context.read<AssistantCubit>().assistants;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount:assistants?.length ?? 0,
      itemBuilder: (context, index) {
        return TimelineAssistantItem(
          assistants: assistants![index],
          isLast: index == assistants.length - 1,
        );
      },
    );
  }
}


class TimelineAssistantItem extends StatelessWidget {
  final Assistant assistants;
  final bool isLast;

  const TimelineAssistantItem({
    Key? key,
    required this.assistants,
    required this.isLast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline line and dot
          SizedBox(
            width: 20,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.only(left: 5),
                      color: Colors.grey.shade300,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Assistant content
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    assistants.title ?? "",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                   Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      assistants.description ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        assistants.date.toString()?? "",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Icon(
                            assistants.isActive ?? false
                                ? Icons.notifications_active
                                : Icons.notifications_none,
                            size: 18,
                            color: assistants.isActive ?? false
                                ? Colors.blue
                                : Colors.grey.shade500,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            assistants.isActive ??  false
                                ? 'Set Assistant (${assistants.remindedTime})'
                                : 'Set Assistant',
                            style: TextStyle(
                              color:(assistants.isActive ??  false)
                                  ? Colors.blue
                                  : Colors.grey.shade500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}