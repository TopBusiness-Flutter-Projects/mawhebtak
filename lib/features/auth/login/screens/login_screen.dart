import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/models/login_model.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/core/widgets/custom_text_form_field.dart';
import 'package:mawhebtak/features/auth/login/cubit/cubit.dart';
import 'package:mawhebtak/features/auth/login/cubit/state.dart';
import 'package:mawhebtak/features/auth/login/screens/widgets/register_or_login_with_goole_or_facebook.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LoginCubit>();
    return Scaffold(
        body: BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return Form(
        key: cubit.formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              50.h.verticalSpace,
              Image.asset(
                ImageAssets.appIconWhite,
                height: 80.h,
                width: 250.w,
              ),
              50.h.verticalSpace,
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "email_address".tr(),
                      style:
                          TextStyle(color: AppColors.darkGray, fontSize: 14.sp),
                    ),
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                      controller: cubit.emailController,
                      hintText: "Example@mail.com",
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(10.0.h),
                        child: SvgPicture.asset(
                          ImageAssets.emailIcon,
                        ),
                      ),
                    ),
                    20.h.verticalSpace,
                    Text(
                      "password".tr(),
                      style:
                          TextStyle(color: AppColors.darkGray, fontSize: 14.sp),
                    ),
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      controller: cubit.passwordController,
                      isPassword: true,
                      hintTextSize: 18.sp,
                      hintText: ("● ● ● ● ● ● ● ● ● ●"),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          ImageAssets.passwordIcon,
                        ),
                      ),
                    ),
                    20.h.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.forgetPasswordRoute);
                          },
                          child: Text(
                            "forget_password".tr(),
                            style: TextStyle(
                                color: AppColors.secondPrimary,
                                fontSize: 14.sp,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.secondPrimary),
                          ),
                        ),
                        30.w.horizontalSpace,
                        Expanded(
                          child: CustomButton(
                              onTap: () {
                                if (cubit.formKey.currentState!.validate()) {
                                  Preferences.instance.setUser(LoginModel());
                                  Navigator.pushNamed(context, Routes.mainRoute);
                                }
                              },
                              title: 'login'.tr()),
                        ),
                      ],
                    ),
                    30.h.verticalSpace,
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        textAlign: TextAlign.center,
                        "or_login_with".tr(),
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                    10.h.verticalSpace,
                    const GoogleAndFacebookWidget(),
                    20.h.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.newAccountRoute);
                      },
                      child: Container(
                        padding: EdgeInsets.all(15.h),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primary),
                            borderRadius: BorderRadius.circular(10)),
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "create_new_account".tr(),
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    20.h.verticalSpace,
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        textAlign: TextAlign.center,
                        "skip_login".tr(),
                        style: TextStyle(
                            color: AppColors.secondPrimary,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.secondPrimary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }));
  }
}
