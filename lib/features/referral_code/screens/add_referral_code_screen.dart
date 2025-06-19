import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/features/referral_code/cubit/referral_code_cubit.dart';
import 'package:mawhebtak/features/referral_code/cubit/referral_code_state.dart';

import '../../../../core/exports.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class AddReferralScreen extends StatefulWidget {
  const AddReferralScreen({super.key});

  @override
  State<AddReferralScreen> createState() => _AddReferralScreenState();
}

class _AddReferralScreenState extends State<AddReferralScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ReferralCodeCubit>();

    return BlocBuilder<ReferralCodeCubit, ReferralCodeState>(
        builder: (BuildContext context, state) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: SvgPicture.asset(AppIcons.correctGreen)),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "account_activated".tr(),
                textAlign: TextAlign.center,
                style: getSemiBoldStyle(
                  fontSize: 20.sp,
                  color: AppColors.primary,
                  

                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Text(
                 "thank_you_all_features".tr(),
                  style: getMediumStyle(
                    fontSize: 14.sp,
                    color: AppColors.grey,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomButton(
                title: 
               
                  "next".tr(),
                  onTap: 
                
                
                () {
                  AwesomeDialog(
                      closeIcon: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            cubit.codeController.clear();
                          },
                          child: Icon(Icons.close)),
                      showCloseIcon: true,
                      dialogBackgroundColor: AppColors.white,
                      context: context,
                      customHeader: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          ImageAssets.logoImage,
                        ),
                      ),
                      animType: AnimType.topSlide,
                      //   showCloseIcon: true,
                       body: BlocBuilder<ReferralCodeCubit, ReferralCodeState>(
                        builder: (BuildContext context, state) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                "enter_code_to_get_points".tr(),
                                style: getRegularStyle(fontSize: 16.sp),
                              ),
                              CustomTextField(
                                onChanged: (value) {
                                  cubit.changeCode(value);
                                },
                                controller: cubit.codeController,
                                keyboardType: TextInputType.number,
                                hintText: "enter_code".tr(),
                              ),
                              Row(children: [
                                Expanded(
                                  child: CustomButton(
                                    title: "skip".tr(),
                                    
                                    onTap: () {
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          Routes.mainRoute, (route) => false);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                if (cubit.codeController.text.isNotEmpty)
                                  Expanded(
                                    child: CustomButton(
                                      title: "next".tr(),
                                      onTap: () {
                                        cubit.addReferralCode(context,
                                           );
                                      },
                                    ),
                                  ),
                              ])
                            ],
                          );
                        },
                      )).show();
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
