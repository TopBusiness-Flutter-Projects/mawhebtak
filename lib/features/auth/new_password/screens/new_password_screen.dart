import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';

import 'package:mawhebtak/features/auth/new_password/cubit/new_password_cubit.dart';
import 'package:mawhebtak/features/auth/new_password/cubit/new_password_state.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<NewPasswordCubit>();
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<NewPasswordCubit, NewPasswordState>(
            builder: (context, state) {
          return Column(
            children: [
              CustomSimpleAppbar(
                title: "new_password".tr(),
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
                          "new_password".tr(),
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        CustomTextField(
                          hintTextSize: 18.sp,
                          controller: cubit.passwordController,
                          hintText: "● ● ● ● ● ● ● ● ● ●",
                        ),
                        Text(
                          "confirm_new_password".tr(),
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        CustomTextField(
                          hintTextSize: 18.sp,
                          controller: cubit.confirmPasswordController,
                          hintText: "● ● ● ● ● ● ● ● ● ●",
                        ),
                        CustomButton(
                          title: 'reset_password'.tr(),
                          onTap: () {
                            //!
                            cubit.resetPassword(context);
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
