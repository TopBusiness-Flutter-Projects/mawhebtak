
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/features/auth/new_account/cubit/new_account_cubit.dart';
import 'package:mawhebtak/features/auth/verification/cubit/verification_cubit.dart';
import 'package:mawhebtak/features/auth/verification/cubit/verification_state.dart';
import 'package:pinput/pinput.dart';
import 'widget/custom_timer_widget.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key, required this.isRegister});

  final bool isRegister;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomSimpleAppbar(title: "verification".tr()),
            BlocBuilder<VerificationCubit, VerificationState>(
                builder: (context, state) {
              var cubit = context.read<VerificationCubit>();
              var cubit2 = context.read<NewAccountCubit>();

              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                        child: Image.asset(
                          ImageAssets.pinCodeImage,
                          width: 160.w,
                          height: 160.h,
                        ),
                      ),
                      Text(
                        "title_otp".tr(),
                        style: TextStyle(
                            color: AppColors.black.withOpacity(0.7),
                            fontSize: 16.sp),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 10.h,
                          bottom: 10.h,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 10.h,
                            bottom: 10.h,
                          ),
                          child: Text(
                            '${"description_otp".tr()} ${cubit2.emailAddressController.text}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.darkGray.withOpacity(0.5),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                        child: Pinput(
                          // onChanged: (value) {
                          //   cubit.clearError();
                          // },
                          // onSubmitted: (value) {
                          //   cubit.clearError();
                          // },
                          controller:
                              cubit.pinController, // Attach the controller
                          length: 6,
                          defaultPinTheme: PinTheme(
                            width: 40.w,
                            height: 40.w,
                            textStyle: getMediumStyle(
                              fontSize: 14.sp,
                              color: AppColors.white,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.grayLite,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: AppColors.grayLite,
                              ),
                            ),
                          ),
                          submittedPinTheme: PinTheme(
                            width: 40.w,
                            height: 40.w,
                            textStyle: getMediumStyle(
                              fontSize: 14.sp,
                              color: AppColors.white,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          focusedPinTheme: PinTheme(
                            width: 40.w,
                            height: 40.w,
                            textStyle: getMediumStyle(
                              fontSize: 14.sp,
                              color: AppColors.primary,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.grayLite,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: AppColors.redLight,
                              ),
                            ),
                          ),
                          showCursor: true,
                
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please_enter_verification_code'.tr();
                            }
                            return null;
                          },
                          // onCompleted: (pin) {
                          //   cubit.validateOTP(isRegister, context);
                          // },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: CustomButton(
                          title: "verify".tr(),
                          onTap: () {
                            cubit.validateOTP(widget.isRegister, context);
                            //! Regiser
                
                            // Navigator.pushNamed(context, Routes.newPasswordRoute);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (cubit.timerDate != null)
                              CountdownTimer(
                                  targetTime: cubit.timerDate ??
                                      DateTime.now()
                                          .add(const Duration(seconds: 60))),
                            SizedBox(
                              width: 5.w,
                            ),
                            InkWell(
                              onTap: () {
                                var cubitx = context.read<NewAccountCubit>();
                                if (cubit.timerDate == null) {
                                  cubit.validateData(
                                    context,
                                    email: cubitx.emailAddressController.text,
                                    name: cubitx.fullNameController.text,
                                    password: cubitx.passwordController.text,
                                    userTypeId:
                                        cubitx.selectedUserType?.id?.toString() ??
                                            '',
                                    userSubTypeId: cubitx.selectedUserSubType?.id
                                            ?.toString() ??
                                        '',
                                  );
                                }
                              },
                              child: Text("send_again".tr(),
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: cubit.timerDate == null
                                          ? AppColors.darkGray.withOpacity(0.8)
                                          : AppColors.darkGray.withOpacity(0.4))),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
