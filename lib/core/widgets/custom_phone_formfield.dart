import 'package:mawhebtak/core/exports.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
class CustomPhoneFormField extends StatelessWidget {
  const CustomPhoneFormField({
    super.key,
    this.onCountryChanged,
    this.onChanged,
    this.controller,
    this.title,
    this.enabled = true,
    this.initialValue,
    this.prefixIcon,
    this.suffixIcon,
  });

  final void Function(Country)? onCountryChanged;
  final void Function(PhoneNumber)? onChanged;
  final TextEditingController? controller;
  final bool? enabled;
  final String? initialValue;
  final String? title;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: getMediumStyle(
                  color: AppColors.secondPrimary, fontSize: 14.sp),
            ),
            SizedBox(height: 1.h),
          ],
          Directionality(
            textDirection: TextDirection.ltr,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 3.0.w),
              child: IntlPhoneField(
                controller: controller,
                showCountryFlag: true,
                dropdownTextStyle: getBoldStyle(fontSize: 13.sp),
                keyboardType: TextInputType.number,
                disableLengthCheck: false,
                showDropdownIcon: false,
                decoration: InputDecoration(
                    prefixIcon: prefixIcon,
                    suffixIcon: suffixIcon,
                    filled: true,
                    fillColor: enabled!
                        ? AppColors.white
                        : AppColors.gray.withOpacity(0.5),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 18, vertical: 5.h),
                    hintText: '1023654789',
                    hintStyle:
                        getRegularStyle(color: AppColors.gray, fontSize: 15.sp),
                    errorStyle: getRegularStyle(color: AppColors.red),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.grayLite, width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(15.r))),
                    disabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.grayLite, width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(10.r))),
                    // focused border style
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.primary, width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(10.r))),

                    // error border style
                    errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.red, width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(10.r))),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.red, width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(10.r)))),
                onCountryChanged: onCountryChanged,
                style: getBoldStyle(fontSize: 13.sp),
                initialValue: initialValue ?? '+20',
                // initialCountryCode: 'EG', // Saudi Arabia country code
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}