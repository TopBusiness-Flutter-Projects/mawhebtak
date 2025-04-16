import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/custom_simple_appbar.dart';
import 'package:mawhebtak/features/auth/new_password/cubit/new_password_cubit.dart';
import 'package:mawhebtak/features/auth/new_password/cubit/new_password_state.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

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
                title: "terms_and_condition".tr(),
              ),
              Expanded(
                child: Container(
                  color: AppColors.grayLite.withOpacity(0.3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      20.h.verticalSpace,
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
                          width: double.infinity,
                          decoration: BoxDecoration(color: AppColors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "terms_and_condition".tr(),
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              20.h.verticalSpace,
                              Text(
                                "terms_and_condition_desc".tr(),
                                style: TextStyle(
                                    wordSpacing: 1.2,
                                    height: 1.7,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              40.h.verticalSpace,
                              Text(
                                "privacy".tr(),
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              20.h.verticalSpace,
                              Text(
                                "privacy_desc".tr(),
                                style: TextStyle(
                                    wordSpacing: 1.2,
                                    height: 1.7,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
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
