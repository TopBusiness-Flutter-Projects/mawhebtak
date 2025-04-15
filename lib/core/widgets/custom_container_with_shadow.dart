import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainerWithShadow extends StatelessWidget {
  const CustomContainerWithShadow({
    super.key,
    required this.child,
    this.height,
    this.reduis,
    this.width,
    this.isShadow = true,  this.color,this.border
  });

  final Widget child;
  final Color? color;
  final double? height;
  final double? width;
  final double? reduis;
  final bool isShadow;
  final bool ?border;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color:color?? Colors.white,
        border: border==true?Border.all(color: Colors.grey.shade300):null,
        borderRadius:BorderRadius.circular( reduis??20.r),
        boxShadow: isShadow
            ? [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // Shadow position
          ),
        ]
            : [], // No shadow when isShadow is false
      ),
      child: child,
    );
  }
}
