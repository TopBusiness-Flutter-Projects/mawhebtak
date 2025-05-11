import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/preferences/hive/models/work_model.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_cubit.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_state.dart';

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
    context
        .read<AssistantCubit>()
        .getAssistants(widget.work?.id ?? 0);
    context.read<AssistantCubit>().getWorks();
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
                    return Expanded(
                      child: Container(
                        decoration: BoxDecoration(color: AppColors.grayLite),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            10.h.verticalSpace,
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20.w,
                                  right: 20.w,
                                  bottom: 10.h,
                                  top: 10.h),
                              child: Text(
                                "my_work".tr(),
                                style: TextStyle(
                                    color: AppColors.blackLite,
                                    fontSize: 14.sp),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: Container(
                                decoration:
                                    BoxDecoration(color: AppColors.white),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.h, horizontal: 20.w),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(AppIcons.bagIcon),
                                      10.w.horizontalSpace,
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.white),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.work?.title ?? "",
                                                style: getMediumStyle(
                                                    fontSize: 14.sp),
                                              ),
                                              10.h.verticalSpace,
                                              Text(
                                                "${widget.work?.assistants?.length ?? 0} ${"assistant".tr()}",
                                                style: getMediumStyle(
                                                  fontSize: 13.sp,
                                                  color:
                                                      AppColors.secondPrimary,
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
                            20.h.verticalSpace,
                             Expanded(child: AssistantsList(work: widget.work!,)),
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
                onTap: () async {
                  final result = await Navigator.pushNamed(
                    context,
                    Routes.addAssistantRoute,
                    arguments: {
                      'work': widget.work,
                    },
                  );

                  if (result != null) {
                    context.read<AssistantCubit>().getAssistants(widget.work?.id ?? 0);
                  }
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
  const AssistantsList({Key? key, required this.work}) : super(key: key);
  final WorkModel work;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssistantCubit, AssistantState>(
      builder: (context, state) {
        var assistants = context.watch<AssistantCubit>().assistants;

        if (assistants == null || assistants.isEmpty) {
          return Center(
              child: Text("no_assistant".tr())); // أو Spinner لو في تحميل
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: assistants.length,
          itemBuilder: (context, index) {
            return TimelineAssistantItem(
              work: work,
              assistants: assistants[index],
              isLast: index == assistants.length - 1,
            );
          },
        );
      },
    );
  }
}

class TimelineAssistantItem extends StatelessWidget {
  final Assistant assistants;
  final bool isLast;
  final WorkModel work;

  const TimelineAssistantItem({
    Key? key,
    required this.assistants,
    required this.isLast, required this.work,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AssistantCubit>();

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
           SizedBox(width: 12.w),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (assistants.image != null && assistants.image!.isNotEmpty && File(assistants.image!).existsSync())
                    Image.file(
                      File(assistants.image ?? ""),
                      fit: BoxFit.fill,
                      height: 200.h,
                      width: double.infinity,
                    ),
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
                  8.h.verticalSpace,
                  Row(
                    children: [
                      assistants.date != null
                          ? Text(
                        DateFormat('d MMMM, y').format(assistants.date!),
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      )
                          : Text(
                        'No Date',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12.sp,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Icon(
                            assistants.isActive ?? false
                                ? Icons.notifications_active
                                : Icons.notifications_none,
                            size: 12,
                            color: assistants.isActive ?? false
                                ? Colors.blue
                                : Colors.grey.shade500,
                          ),
                           SizedBox(width: 4.w),
                          Text(
                            (assistants.remindedTime != null)
                                ? 'Set Reminder (${DateFormat('dd MMM yyyy • hh:mm a').format(assistants.remindedTime!)})'
                                : 'Set Reminder',
                            style: TextStyle(
                              color: (assistants.isActive ?? false) ? Colors.blue : Colors.grey.shade500,
                              fontSize: 12,
                            ),
                          ),

                          PopupMenuButton<String>(
                            onSelected: (value) async {
                              if (value == 'edit') {
                                final result = await Navigator.pushNamed(
                                  context,
                                  Routes.addAssistantRoute,
                                  arguments: {
                                    'work': work,
                                    'assistant': assistants,
                                  },
                                );

                                if (result != null) {
                                  cubit.getAssistants(work.id ?? 0);
                                }
                              } else if (value == 'delete') {
                                cubit.deleteAssistant(
                                  context,
                                  workId: work.id ?? 0,
                                  assistantId: assistants.id ?? 0,
                                );
                              }
                            },


                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Text('Edit'),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ],
                            icon: const Icon(Icons.more_vert, size: 18),
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
