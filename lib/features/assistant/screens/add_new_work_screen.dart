import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/preferences/hive/models/work_model.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_cubit.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_state.dart';
import 'package:mawhebtak/features/events/screens/widgets/custom_apply_app_bar.dart';

class AddNewWorkScreen extends StatefulWidget {
  const AddNewWorkScreen({super.key, this.work});
  final WorkModel? work;

  @override
  State<AddNewWorkScreen> createState() => _AddNewWorkScreenState();
}

class _AddNewWorkScreenState extends State<AddNewWorkScreen> {
  late AssistantCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<AssistantCubit>();
    if (widget.work != null) {
      cubit.workNameController.text = widget.work!.title ?? '';
    } else {
      cubit.workNameController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          10.h.verticalSpace,
          CustomAppBarWithClearWidget(title: "new_word".tr()),
          BlocBuilder<AssistantCubit, AssistantState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(
                    left: 20.w, right: 20.w, bottom: 20.h, top: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("description_from_new_work".tr(),
                        style: getMediumStyle(fontSize: 19.sp)),
                    10.h.verticalSpace,
                    Text("work_name".tr(),
                        style: getMediumStyle(
                            fontSize: 14.sp, color: AppColors.blackLite)),
                    CustomTextField(

                      controller: cubit.workNameController,
                      hintText: "go_to_cinema".tr(),
                    ),
                    10.h.verticalSpace,
                    CustomButton(
                      title: widget.work == null ? "add".tr() : "edit".tr(),
                      onTap: () {
                        final workName = cubit.workNameController.text.trim();

                        if (workName.isEmpty) {
                          errorGetBar("please_add_work_name".tr());
                          return;
                        }

                        if (widget.work == null) {
                          cubit.addWork(context);
                        } else {
                          cubit.updateWork(context,
                              workId: widget.work!.id ?? 0, newTitle: workName);
                        }

                        Navigator.pop(context, true); // لتحديث القائمة
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
