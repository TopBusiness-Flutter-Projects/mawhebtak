import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/core/widgets/custom_text_form_field.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_cubit.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_state.dart';
import 'package:mawhebtak/features/events/screens/widgets/custom_apply_app_bar.dart';

class AddNewAssistantScreen extends StatefulWidget {
  const AddNewAssistantScreen({super.key});

  @override
  State<AddNewAssistantScreen> createState() => _AddNewAssistantScreenState();
}

class _AddNewAssistantScreenState extends State<AddNewAssistantScreen> {
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
                    CustomButton(title: "create_work".tr()),
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
