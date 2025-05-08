import 'package:easy_localization/easy_localization.dart';
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
    var cubit =  context.read<AssistantCubit>();
    return Scaffold(
      body: Column(
        children: [
          10.h.verticalSpace,
          CustomAppBarWithClearWidget(title: "new_word".tr()),
          BlocBuilder<AssistantCubit,AssistantState>(
            builder: (context,state) {
              return Padding(
                padding:  EdgeInsets.only(left: 20.w,right: 20.w,bottom: 20.h,top: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("description_from_new_work".tr(),style: getMediumStyle(fontSize: 19.sp),),
                   10.h.verticalSpace,
                    Text("work_name".tr(),style: getMediumStyle(fontSize: 14.sp,color: AppColors.blackLite),),
                     CustomTextField(
                      controller: cubit.workNameController,
                      hintText: "sanaa adel",
                    ),
                    10.h.verticalSpace,
                    CustomButton(
                      title: widget.work == null ? "create_work".tr() : "save".tr(),
                      onTap: () async {
                        final workName = cubit.workNameController.text.trim();
                        if (workName.isNotEmpty) {
                          if (widget.work == null) {
                            cubit.addNewWork(context);
                            Navigator.pop(context);
                          } else {
                            cubit.updateWork(context, workId: widget.work!.id ?? 0, newTitle: workName);
                            Navigator.pop(context);
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            errorGetBar("please_add_work_name".tr()),
                          );
                        }
                      },
                    ),


                  ],
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}
