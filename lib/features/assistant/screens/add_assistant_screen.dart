import 'dart:developer';
import 'dart:typed_data';

import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/preferences/hive/models/work_model.dart';
import 'package:mawhebtak/core/utils/custom_pick_media.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_cubit.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_state.dart';
import 'package:mawhebtak/features/events/screens/widgets/custom_apply_app_bar.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AddAssistantScreen extends StatefulWidget {
  const AddAssistantScreen({super.key, this.work, this.assistant});
  final WorkModel? work;
  final Assistant? assistant;

  @override
  State<AddAssistantScreen> createState() => _AddAssistantScreenState();
}

class _AddAssistantScreenState extends State<AddAssistantScreen> {
  @override
  void initState() {
    super.initState();
    final work = widget.work;
    final assistant = widget.assistant;
    final cubit = context.read<AssistantCubit>();

    if (work != null) {
      cubit.workNameController.text = work.title ?? "";
    }

    if (assistant != null) {
      cubit.assistantTitleController.text = assistant.title ?? "";
      cubit.assistantDescriptionController.text = assistant.description ?? "";
      cubit.selectedReminderDate = assistant.remindedTime;
    }
    log('video ${widget.assistant?.video} image ${widget.assistant?.image}');
    if (widget.assistant?.video != null) {
      generateThumbnail();
    } else {
      thumbnailData = null;
    }
  }

  Uint8List? thumbnailData;

  Future<void> generateThumbnail() async {
    try {
      final data = await VideoThumbnail.thumbnailData(
        video: widget.assistant?.video ?? '',
        imageFormat: ImageFormat.JPEG,
        maxWidth: 128,
        quality: 25,
      );

      setState(() {
        thumbnailData = data;
      });
    } catch (e) {
      // setState(() {});
      print('Thumbnail generation failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AssistantCubit>();
    return Scaffold(
      body: Column(
        children: [
          10.h.verticalSpace,
          CustomAppBarWithClearWidget(title: "add_assistant".tr()),
          BlocBuilder<AssistantCubit, AssistantState>(
              builder: (context, state) {
            return Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    10.h.verticalSpace,
                    CustomPickMediaWidget(
                      deleteImage: () {
                        //!

                        cubit.clearMedia();

                        setState(() {
                          widget.assistant?.image = null;
                          widget.assistant?.video = null;
                          thumbnailData = null;
                        });
                      },
                      thumbnailData: thumbnailData,
                      imagePath: widget.assistant?.image,
                      onTap: () async {
                        await cubit.pickMedia(context);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("assistant_title".tr(),
                              style: TextStyle(fontSize: 14.sp)),
                          CustomTextField(
                              controller: cubit.assistantTitleController,
                              hintText: "assistant_title".tr()),
                          Text("assistant_description".tr(),
                              style: TextStyle(fontSize: 14.sp)),
                          CustomTextField(
                            controller: cubit.assistantDescriptionController,
                            isMessage: true,
                            hintText: "assistant_description".tr(),
                          ),
                          GestureDetector(
                            onTap: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: cubit.selectedReminderDate ??
                                    DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(5100),
                              );

                              if (pickedDate != null) {
                                final TimeOfDay? pickedTime =
                                    await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                      cubit.selectedReminderDate ??
                                          DateTime.now()),
                                );

                                if (pickedTime != null) {
                                  final DateTime finalDateTime = DateTime(
                                    pickedDate.year,
                                    pickedDate.month,
                                    pickedDate.day,
                                    pickedTime.hour,
                                    pickedTime.minute,
                                  );

                                  cubit.updateSelectedDate(finalDateTime);
                                }
                              }
                            },
                            child: Row(
                              children: [
                                Icon(Icons.notifications_sharp,
                                    color: AppColors.grayLight, size: 20.sp),
                                10.w.horizontalSpace,
                                Text("set_reminder_for_assistant".tr(),
                                    style: TextStyle(
                                        color: AppColors.grayLight,
                                        fontSize: 14.sp)),
                                const Spacer(),
                                if (cubit.selectedReminderDate != null)
                                  GestureDetector(
                                    onTap: () {
                                      cubit.clearSelectedDate();
                                    },
                                    child: Icon(
                                      Icons.clear,
                                      color: AppColors.red,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          if (cubit.selectedReminderDate != null)
                            CustomTextField(
                              enabled: false,
                              hintText: DateFormat('yyyy-MM-dd', 'en')
                                  .format(cubit.selectedReminderDate!),
                            ),
                          CustomButton(
                            title: widget.assistant != null
                                ? "edit".tr()
                                : "add_assistant".tr(),
                            onTap: () {
                              if (widget.work != null) {
                                if (widget.assistant != null) {
                                  cubit.updateAssistant(
                                    context,
                                    workId: widget.work!.id!,
                                    oldAssistant: widget.assistant!,
                                  );
                                } else {
                                  cubit.addAssistant(context,
                                      workId: widget.work!.id!,
                                      workTitle: widget.work?.title ?? "");
                                }
                              } else {
                                errorGetBar("no_work".tr());
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
