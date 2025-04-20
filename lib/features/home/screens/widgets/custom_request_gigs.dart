import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/exports.dart';
import 'follow_button.dart';

class CustomRequestGigstList extends StatelessWidget {
  const CustomRequestGigstList({super.key,
    required this.isLeftPadding,required this.isRightPadding
  });
  final bool isLeftPadding;
  final bool isRightPadding;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsetsDirectional.only(start:isLeftPadding? 16.w:10.w,end: isRightPadding?16.w:0.0),
      child: Stack(
        alignment: Alignment.centerLeft, // Add alignment to the Stack
        children: [
          // Image container
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: SizedBox(
              width: 137.w, // Match image width
              height: 137.w, // Match image height
              child: Image.asset(
                ImageAssets.tasweerPhoto,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay with semi-transparent background for better text visibility
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(16.r),
          //   child: Container(
          //     height: 184.h,
          //     width: 198.w,
          //     color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
          //   ),
          // ),
          // Content to display over image
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, Routes.gigsDetailsScreen);
            },
            child: SizedBox(
              width: 137.w, // Match image width
              height: 137.w, // Match image height
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end, // Center vertically
                  crossAxisAlignment: CrossAxisAlignment.start, // Center horizontally
                  children: [
                    SizedBox(height: 80),

                    Text(

                      "Sports",
                      style: getMediumStyle(color: AppColors.white, fontSize: 14.sp,),
                      textAlign: TextAlign.end,
                    ),





                    SizedBox(height: 5.h,)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
