import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/core/widgets/custom_simple_appbar.dart';
import 'package:mawhebtak/core/widgets/custom_text_form_field.dart';
import 'package:mawhebtak/features/auth/new_account/cubit/new_account_cubit.dart';
import 'package:mawhebtak/features/auth/new_account/cubit/new_account_state.dart';
import 'package:mawhebtak/features/auth/new_account/screens/widgets/role_selection_widget.dart';

import '../../login/screens/widgets/register_or_login_with_goole_or_facebook.dart';

class NewAccountScreen extends StatelessWidget {
  const NewAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<NewAccountCubit>();
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSimpleAppbar(title: "new_account".tr()),
            BlocBuilder<NewAccountCubit,NewAccountState>(
              builder: (context,state) {
                return Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const RoleSelectionWidget(),
                          Padding(
                            padding:  EdgeInsets.only(top: 20.h),
                            child: Text("full_name".tr(),style: TextStyle(color: AppColors.blackLite,fontWeight: FontWeight.w400,fontSize: 14.sp),),
                          ),
                           CustomTextField(
                            controller: cubit.fullNameController,
                            hintText: "sanaa adel",
                          ),
                          Padding(
                            padding:  EdgeInsets.only(top: 20.h,bottom: 10.h),
                            child: Text("email_address".tr(),style: TextStyle(color: AppColors.blackLite,fontWeight: FontWeight.w400,fontSize: 14.sp),),
                          ),
                           CustomTextField(
                             controller: cubit.emailAddressController,
                            hintText: "sanaa@gmail.com",
                          )  ,Padding(
                            padding:  EdgeInsets.only(top: 20.h,bottom: 10.h),
                            child: Text("mobile_number".tr(),style: TextStyle(color: AppColors.blackLite,fontWeight: FontWeight.w400,fontSize: 14.sp),),
                          ),
                           CustomTextField(
                            controller: cubit.mobileNumberController,
                            hintText: "01026267452",
                          ),Padding(
                            padding:  EdgeInsets.only(top: 20.h,bottom: 10.h),
                            child: Text("password".tr(),style: TextStyle(color: AppColors.blackLite,fontWeight: FontWeight.w400,fontSize: 14.sp),),
                          ),
                           CustomTextField(
                             controller: cubit.passwordController,
                             hintTextSize: 16.sp,
                            hintText: "● ● ● ● ● ● ● ● ● ●",
                            isPassword: true,
                          ),
                          CustomButton(title: "register".tr(),onTap: () {
                            Navigator.pushNamed(context, Routes.verificationRoute);
                          },),
                          Padding(
                            padding:  EdgeInsets.only(top: 10.h,bottom: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Or sign up with",

                                  style: TextStyle(color: AppColors.blackLite,fontSize: 16.sp),),
                              ],
                            ),
                          ),
                          const GoogleAndFacebookWidget(),
                        ],
                      ),
                    ),
                  ),
                );
              }
            )
          ],
        ),
      ),
    );
  }
}
