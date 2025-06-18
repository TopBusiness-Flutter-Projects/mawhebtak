import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/features/more_screen/cubit/more_cubit.dart';
import 'package:mawhebtak/features/more_screen/cubit/more_state.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<MoreCubit, MoreState>(
            builder: (context, state) {
              var cubit = context.read<MoreCubit>();
          return Column(
            children: [
              CustomSimpleAppbar(
                title: "change_password".tr(),
              ),
              Expanded(
                child: Container(
                  color: AppColors.grayLite.withOpacity(0.3),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 40.h, left: 20.w, right: 20.w, bottom: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "old_password".tr(),
                          style: TextStyle(fontSize: 20.sp),
                        ),
                        CustomTextField(
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please_enter_password'.tr();
                            }
                            return null;
                          },
                          hintTextSize: 20.sp,
                          controller: cubit.oldPasswordController,
                          hintText: "● ● ● ● ● ● ● ● ● ●",

                        ),
                        Text(
                          "new_password".tr(),
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        CustomTextField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please_enter_password'.tr();
                            }
                            return null;
                          },
                          isPassword: true,
                          hintTextSize: 20.sp,
                          controller: cubit.newPasswordController,
                          hintText: "● ● ● ● ● ● ● ● ● ●",
                        ),


                        CustomButton(
                          title: 'change_password'.tr(),
                          onTap: () {
                           cubit.changePassword(context: context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
