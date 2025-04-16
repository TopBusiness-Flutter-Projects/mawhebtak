import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/core/widgets/custom_simple_appbar.dart';
import 'package:mawhebtak/core/widgets/custom_text_form_field.dart';
import 'package:mawhebtak/features/auth/change_password/cubit/change_password_cubit.dart';
import 'package:mawhebtak/features/auth/change_password/cubit/change_password_state.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ChangePasswordCubit>();
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
            builder: (context, state) {
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
                        Text("old_password".tr(),style: TextStyle(fontSize: 14.sp),),
                        CustomTextField(
                          hintTextSize: 18.sp,
                          controller: cubit.oldPasswordController,
                          hintText: "● ● ● ● ● ● ● ● ● ●",
                        ),Text("new_password".tr(),style: TextStyle(fontSize: 14.sp),),
                        CustomTextField(
                          hintTextSize: 18.sp,
                          controller: cubit.passwordController,
                          hintText: "● ● ● ● ● ● ● ● ● ●",
                        ), Text("confirm_new_password".tr(),style: TextStyle(fontSize: 14.sp),),
                        CustomTextField(
                          hintTextSize: 18.sp,
                          controller: cubit.confirmPasswordController,
                          hintText: "● ● ● ● ● ● ● ● ● ●",
                        ),
                        CustomButton(

                          title: 'change_password'.tr(),
                          onTap: () {
                          Navigator.pushNamed(context, Routes.verificationRoute);
                        },),
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
