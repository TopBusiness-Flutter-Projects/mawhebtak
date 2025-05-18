import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_cubit.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_state.dart';
import '../exports.dart';
import '../../features/home/screens/widgets/follow_button.dart';

class CustomPickMediaWidget extends StatelessWidget {
  CustomPickMediaWidget({
    super.key,
    required this.onTap,
    this.deleteImage,
    this.imagePath,
  });
  final Function() onTap;
  String? imagePath;
  void Function()? deleteImage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssistantCubit, AssistantState>(
      builder: (BuildContext context, state) {
        var cubit = context.read<AssistantCubit>();

        return Container(
          color: AppColors.grayLite,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 10.h),
              if (cubit.selectedImage != null)
                Image.file(cubit.selectedImage!,
                    height: 150.h, fit: BoxFit.fill)
              else if (cubit.selectedVideo != null)
                Icon(Icons.videocam, size: 100.sp, color: AppColors.primary)
              else if (imagePath != null && imagePath!.isNotEmpty)
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.file(File(imagePath!),
                        height: 150.h, fit: BoxFit.cover),
                    PositionedDirectional(
                        top: 3,
                        start: 3,
                        child: InkWell(
                          onTap: deleteImage,
                          child: CircleAvatar(
                            backgroundColor: AppColors.white,
                            radius: 15.r,
                            child: Icon(
                              Icons.close,
                              size: 16.sp,
                              color: AppColors.red,
                            ),
                          ),
                        ))
                  ],
                )
              else
                Image.asset(ImageAssets.imagePicked, height: 150.h),
              SizedBox(height: 10.h),
              SizedBox(
                width: 239.w,
                height: 30.h,
                child: GestureDetector(
                  onTap: onTap,
                  child: CustomContainerButton(
                    title: "add_photo_video".tr(),
                    color: AppColors.blueveryLight,
                    textColor: AppColors.primary,
                  ),
                ),
              ),
              10.verticalSpace
            ],
          ),
        );
      },
    );
  }
}
