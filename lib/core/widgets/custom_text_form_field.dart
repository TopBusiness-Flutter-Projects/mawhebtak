import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/core/exports.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? initialValue;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? borderRadius;

  final bool? enabled;
  final bool isMessage;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final double? hintTextSize;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  //FocusNode myFocusNode = FocusNode();
   CustomTextField({
    super.key,
    this.labelText,
    this.prefixIcon,
    this.validator,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.isMessage = false,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.onTap,
    this.isPassword = false,
    this.onSubmitted,
    this.borderRadius,
    this.enabled = true,
    this.hintText,
    this.hintTextSize,
    this.maxLines,
    this.inputFormatters,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  FocusNode myFocusNode = FocusNode();
  bool showPassword = false;
  @override
  void initState() {
    super.initState();

    myFocusNode.addListener(() {
      setState(() {
        // color = Colors.black;
      });
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.isMessage ? 150.h : null,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.w),
        child: TextFormField(
            inputFormatters: widget.inputFormatters,
            enabled: widget.enabled,
            controller: widget.controller,
            expands: false,
            onTap: widget.onTap,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            focusNode: myFocusNode,
            style: getRegularStyle(),
            onChanged: widget.onChanged,
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            maxLines: widget.isMessage ? (widget.maxLines ?? 4) : 1,
            minLines: widget.isMessage ? 4 : 1,
            onFieldSubmitted: widget.onSubmitted,
            initialValue: widget.initialValue,
            obscureText: widget.isPassword ? !showPassword : false,
            decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.grayLite,
                labelText: widget.labelText,
                labelStyle: getRegularStyle(
                    fontHeight: 1.5,
                    color: myFocusNode.hasFocus
                        ? AppColors.primary
                        : AppColors.gray),
                prefixIcon: widget.prefixIcon,
                prefixIconColor:
                    myFocusNode.hasFocus ? AppColors.primary : AppColors.gray,
                suffixIconColor:
                    myFocusNode.hasFocus ? AppColors.primary : AppColors.gray,
                suffixIcon: widget.isPassword
                    ? showPassword
                        ? IconButton(
                            icon: SvgPicture.asset(AppIcons.passwordIcon),
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                          )
                        : IconButton(
                            icon: SvgPicture.asset(AppIcons.passwordIcon),
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            })
                    : widget.suffixIcon,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                hintText: widget.hintText,
                hintStyle: getRegularStyle(
                    color: AppColors.gray,
                    fontSize: widget.hintTextSize ?? 14.sp),
                errorStyle:
                    getRegularStyle(color: AppColors.red, fontSize: 14.sp),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.white, width: 1.5),
                    borderRadius: BorderRadius.all(
                        Radius.circular(widget.borderRadius ?? 10.r))),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.white, width: 1.5),
                    borderRadius: BorderRadius.all(
                        Radius.circular(widget.borderRadius ?? 10.r))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.white, width: 1.5),
                    borderRadius: BorderRadius.all(
                        Radius.circular(widget.borderRadius ?? 10.r))),

                // error border style
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.red, width: 1.5),
                    borderRadius: BorderRadius.all(
                        Radius.circular(widget.borderRadius ?? 10.r))),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.red, width: 1.5),
                    borderRadius: BorderRadius.all(
                        Radius.circular(widget.borderRadius ?? 10.r))))),
      ),
    );
  }
}
