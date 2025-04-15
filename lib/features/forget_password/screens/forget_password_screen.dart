import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/custom_text_form_field.dart';
import 'package:mawhebtak/features/forget_password/cubit/forget_password_cubit.dart';
import 'package:mawhebtak/features/forget_password/cubit/forget_password_state.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_simple_appbar.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ForgetPasswordCubit>();
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
            builder: (context, state) {
          return Column(
            children: [
              CustomSimpleAppbar(
                title: "forget_Password".tr(),
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
                        Text("email_address".tr()),
                        CustomTextField(
                          controller: cubit.emailController,
                          hintText: "Example@mail.com",
                        ),
                        CustomButton(title: 'reset_password'.tr(),onTap: () {
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
