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
        .getAllAssistantFromWork(widget.work?.id ?? 0);
    context.read<AssistantCubit>().getAllWorks();
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
                            20.h.verticalSpace,
                            const Expanded(child: AssistantsList()),
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
                  Navigator.pushNamed(context, Routes.addAssistantRoute,
                      arguments: widget.work);
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
  const AssistantsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssistantCubit, AssistantState>(
      builder: (context, state) {
        var assistants = context.read<AssistantCubit>().assistants;

        if (assistants == null || assistants.isEmpty) {
          return Center(
              child: Text("no_assistant".tr())); // أو Spinner لو في تحميل
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: assistants.length,
          itemBuilder: (context, index) {
            return TimelineAssistantItem(
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

  const TimelineAssistantItem({
    Key? key,
    required this.assistants,
    required this.isLast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AssistantCubit>();
    final workId =
        context.findAncestorWidgetOfExactType<WorkDetailsScreen>()?.work?.id ??
            0;
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
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(
                      height: 150.h,
                      width: double.infinity,
                      child: Image.asset(assistants.image ?? "" ),
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
                      Text(
                        DateFormat('d MMMM, y').format(assistants.date!),
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
                            (assistants.isActive ??
                                    false && assistants.remindedTime != null)
                                ? 'Set Reminder (${DateFormat('d MMMM, y - h:mm a').format(assistants.remindedTime!)})'
                                : 'Set Reminder',
                            style: TextStyle(
                              color: (assistants.isActive ?? false)
                                  ? Colors.blue
                                  : Colors.grey.shade500,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 10),
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                              } else if (value == 'delete') {
                                cubit.deleteAssistant(
                                  context,
                                  workId: workId,
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
