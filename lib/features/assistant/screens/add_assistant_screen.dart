import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/preferences/hive/models/work_model.dart';
import 'package:mawhebtak/core/utils/custom_pick_media.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_cubit.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_state.dart';
import 'package:mawhebtak/features/events/screens/widgets/custom_apply_app_bar.dart';

class AddAssistantScreen extends StatefulWidget {
  const AddAssistantScreen({super.key, this.work});
  final Work? work;
  @override
  State<AddAssistantScreen> createState() => _AddAssistantScreenState();
}

class _AddAssistantScreenState extends State<AddAssistantScreen> {
  @override
  void initState() {
    super.initState();
    final work = widget.work;
    if (work != null) {
      context.read<AssistantCubit>().workNameController.text = work.title ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = context.watch<AssistantCubit>().selectedDate;
    var cubit = context.read<AssistantCubit>();
    return Scaffold(
      body: Column(
        children: [
          10.h.verticalSpace,
          CustomAppBarWithClearWidget(title: "add_assistant".tr()),
          BlocBuilder<AssistantCubit, AssistantState>(
              builder: (context, state) {
            return Column(
              children: [
                10.h.verticalSpace,
                const CustomPickMediaWidget(),
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.w, right: 20.w, bottom: 20.h, top: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "assistant_title".tr(),
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      const CustomTextField(
                        hintText: "task details",
                      ),
                      Text(
                        "assistant_description".tr(),
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      const CustomTextField(
                        isMessage: true,
                        hintText: "task details",
                      ),
                      GestureDetector(
                        onTap: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            cubit.updateSelectedDate(pickedDate);
                          }
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.notifications_sharp,
                              color: AppColors.grayLight,
                              size: 20.sp,
                            ),
                            10.w.horizontalSpace,
                            Text(
                              "set_reminder_for_assistant".tr(),
                              style: TextStyle(
                                color: AppColors.grayLight,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                     if(selectedDate != null)
                       CustomTextField(
                         enabled: false,
                        hintText: DateFormat('yyyy-MM-dd').format(selectedDate)
                      ),
                      CustomButton(title: "add_assistant".tr(),onTap: () {
                        cubit.addAssistantFromWork(context,workId: widget.work?.id?? 0);
                      },),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
