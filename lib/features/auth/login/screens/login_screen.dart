import 'dart:developer';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/utils/widget_from_application.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/features/auth/login/cubit/cubit.dart';
import 'package:mawhebtak/features/auth/login/cubit/state.dart';
import 'package:mawhebtak/features/auth/login/screens/widgets/register_or_login_with_goole_or_facebook.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    context.read<LoginCubit>().signOutFromGmail();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginStateLoading) {
          AppWidgets.create2ProgressDialog(context);
        } else if (state is LoginStateLoaded) {
          if (state.isRegister == 1){
 log("Register");
  Navigator.pop(context);
  Navigator.pushReplacementNamed(context, Routes.addReferralCodeRoute);

          }else{
  Navigator.pop(context);
          Navigator.pushReplacementNamed(context, Routes.mainRoute);
          }    
    
        } else if (state is LoginStateError) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = context.read<LoginCubit>();

        return Scaffold(body:
            BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
          return Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  50.h.verticalSpace,
                  Image.asset(
                    ImageAssets.appIconWhite,
                    height: 100.h,
                    width: 300.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 80.h, left: 20.w, right: 20.w, bottom: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "email_address".tr(),
                          style: TextStyle(
                              color: AppColors.darkGray, fontSize: 18.sp),
                        ),
                        CustomTextField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please_enter_email'.tr();
                            }
                            return null;
                          },
                          controller: emailController,
                          hintText: "Example@mail.com",
                          hintTextSize: 16.sp,
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(10.0.h),
                            child: SvgPicture.asset(
                              AppIcons.emailIcon,
                            ),
                          ),
                        ),
                        20.h.verticalSpace,
                        Text(
                          "password".tr(),
                          style: TextStyle(
                              color: AppColors.darkGray, fontSize: 18.sp),
                        ),
                        CustomTextField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please_enter_password'.tr();
                            }
                            return null;
                          },
                          controller: passwordController,
                          isPassword: true,
                          hintTextSize: 16.sp,
                          hintText: ("● ● ● ● ● ● ● ● ● ●"),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              AppIcons.passwordIcon,
                            ),
                          ),
                        ),
                        20.h.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.forgetPasswordRoute);
                              },
                              child: Text(
                                "forget_password".tr(),
                                style: TextStyle(
                                    color: AppColors.secondPrimary,
                                    fontSize: 18.sp,
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.secondPrimary),
                              ),
                            ),
                            // 30.w.horizontalSpace,
                            Flexible(
                              child: CustomButton(
                                  onTap: () async {
                                    if (formKey.currentState!.validate()) {
                                      cubit.login(
                                        emailController.text,
                                        passwordController.text,
                                        context,
                                      );
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
                            style: TextStyle(fontSize: 18.sp),
                          ),
                        ),
                        10.h.verticalSpace,
                        const GoogleAndFacebookWidget(),
                        20.h.verticalSpace,
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.newAccountRoute);
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
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                        20.h.verticalSpace,
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.mainRoute);
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              textAlign: TextAlign.center,
                              "skip_login".tr(),
                              style: TextStyle(
                                  color: AppColors.secondPrimary,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.secondPrimary,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        10.h.verticalSpace
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }));
      },
    );
  }
}
