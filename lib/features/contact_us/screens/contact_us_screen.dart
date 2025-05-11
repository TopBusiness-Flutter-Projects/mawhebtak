import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/core/widgets/custom_simple_appbar.dart';
import 'package:mawhebtak/core/widgets/custom_text_form_field.dart';
import 'package:mawhebtak/features/contact_us/cubit/contact_us_cubit.dart';
import 'package:mawhebtak/features/contact_us/cubit/contact_us_state.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ContactUsCubit>();
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<ContactUsCubit, ContactUsState>(
            builder: (context, state) {
          return Column(
            children: [
              CustomSimpleAppbar(
                title: type == "advertising_and_publicity"
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
                        ),
                        Text(
                          "phone_number".tr(),
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        CustomTextField(
                          hintTextSize: 18.sp,
                          controller: cubit.phoneNumberController,
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
                          onTap: () {},
                        ),
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
