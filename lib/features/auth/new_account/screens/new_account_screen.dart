import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/utils/widget_from_application.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/features/auth/new_account/cubit/new_account_cubit.dart';
import 'package:mawhebtak/features/auth/new_account/cubit/new_account_state.dart';
import 'package:mawhebtak/features/auth/new_account/screens/widgets/role_selection_widget.dart';
import '../../login/screens/widgets/register_or_login_with_goole_or_facebook.dart';
import '../../verification/cubit/verification_cubit.dart';
import '../data/model/user_types.dart';

class NewAccountScreen extends StatefulWidget {
  const NewAccountScreen({super.key});

  @override
  State<NewAccountScreen> createState() => _NewAccountScreenState();
}

class _NewAccountScreenState extends State<NewAccountScreen> {
  @override
  void initState() {
    super.initState();

    final cubit = BlocProvider.of<NewAccountCubit>(context);

    cubit.getDataUserType(); // Only fetch if not already loaded
  }

  bool isLoaded = true;

  List<MainRegisterUserTypesData>? listType;
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<NewAccountCubit>();
    return BlocConsumer<NewAccountCubit, NewAccountState>(
      listener: (context, state) {
        if (state is LoadingGetUserTypesState) {
          isLoaded = true;
        } else if (state is ErrorGetUserTypesState) {
          errorGetBar(state.errorMessage);
          isLoaded = false;
        } else if (state is LoadedGetUserTypesState) {
          listType = state.data.data ?? [];
          isLoaded = false;
        } else if (state is LoadingAddNewAccountState) {
          AppWidgets.createProgressDialog(
              context: context, msg: 'loading'.tr());
        } else if (state is ErrorAddNewAccountState) {
          errorGetBar(state.errorMessage);
          Navigator.pop(context);
        } else {}
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSimpleAppbar(title: "new_account".tr()),
                BlocBuilder<NewAccountCubit, NewAccountState>(
                    builder: (context, state) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.h),
                            isLoaded
                                ? SizedBox(
                                    height: 3.h,
                                    child: LinearProgressIndicator(
                                        color: AppColors.primary))
                                : RoleSelectionWidget(list: listType ?? []),
                            Padding(
                                padding: EdgeInsets.only(top: 20.h),
                                child: Text("full_name".tr(),
                                    style: TextStyle(
                                        color: AppColors.blackLite,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp))),
                            CustomTextField(
                                controller: cubit.fullNameController,
                                hintText: "full name"),
                            Padding(
                              padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                              child: Text(
                                "email_address".tr(),
                                style: TextStyle(
                                    color: AppColors.blackLite,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp),
                              ),
                            ),
                            CustomTextField(
                              controller: cubit.emailAddressController,
                              hintText: "email@gmail.com",
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                              child: Text(
                                "mobile_number".tr(),
                                style: TextStyle(
                                    color: AppColors.blackLite,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp),
                              ),
                            ),
                            CustomTextField(
                              controller: cubit.mobileNumberController,
                              hintText: "01xxxxxxxx",
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                              child: Text(
                                "password".tr(),
                                style: TextStyle(
                                    color: AppColors.blackLite,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp),
                              ),
                            ),
                            CustomTextField(
                              controller: cubit.passwordController,
                              hintTextSize: 16.sp,
                              hintText: "● ● ● ● ● ● ● ● ● ●",
                              isPassword: true,
                            ),
                            CustomButton(
                              title: "register".tr(),
                              onTap: () {
                                context.read<VerificationCubit>().validateData(
                                    context,
                                    email: cubit.emailAddressController.text,
                                    name: cubit.fullNameController.text,
                                    password: cubit.passwordController.text,
                                    phone: cubit.mobileNumberController.text,
                                    userTypeId: cubit.selectedUserType?.id
                                            ?.toString() ??
                                        '');

//make validate

                                // cubit.register(context);
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Or sign up with",
                                    style: TextStyle(
                                        color: AppColors.blackLite,
                                        fontSize: 16.sp),
                                  ),
                                ],
                              ),
                            ),
                            const GoogleAndFacebookWidget(),
                          ],
                        ),
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
        );
      },
    );
  }
}
