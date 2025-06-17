import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/features/more_screen/cubit/more_state.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/utils/check_login.dart';
import '../cubit/more_cubit.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key, required this.type});
  final String type;

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  void initState() {
    context.read<MoreCubit>().saveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<MoreCubit>();
    final formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<MoreCubit, MoreState>(builder: (context, state) {
          return Form(
            key: formKey,
            child: Column(
              children: [
                CustomSimpleAppbar(
                  title: widget.type == "advertising_and_publicity"
                      ? "advertising_and_publicity".tr()
                      : "complaining".tr(),
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
                            "title".tr(),
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          CustomTextField(
                            hintTextSize: 18.sp,
                            controller: cubit.titleController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter a title';
                              }
                              return null;
                            },
                          ),
                          Text(
                            "phone_number".tr(),
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          CustomTextField(
                            hintTextSize: 18.sp,
                            controller: cubit.phoneNumberController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter a phone';
                              }
                              return null;
                            },
                          ),
                          Text(
                            "message".tr(),
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          CustomTextField(
                            isMessage: true,
                            hintTextSize: 18.sp,
                            controller: cubit.messageController,
                          ),
                          CustomButton(
                              title: 'send'.tr(),
                              onTap: () async {
                                final user =
                                    await Preferences.instance.getUserModel();
                                if (user.data?.token == null) {
                                  checkLogin(context);
                                } else {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    final user = await Preferences.instance
                                        .getUserModel();
                                    if (user.data?.token == null) {
                                      checkLogin(context);
                                    } else {
                                      cubit.contactUs(
                                        isComplaining:
                                            widget.type == 'complaints',
                                        context: context,
                                      );
                                    }
                                  }
                                }
                                ;
                              }),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
