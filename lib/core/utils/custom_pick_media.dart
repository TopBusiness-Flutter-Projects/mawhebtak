import 'dart:developer';
import 'dart:typed_data';

import 'package:mawhebtak/features/assistant/cubit/assistant_cubit.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_state.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../exports.dart';
import '../../features/home/screens/widgets/follow_button.dart';

class CustomPickMediaWidget extends StatefulWidget {
  CustomPickMediaWidget({
    super.key,
    required this.onTap,
    this.deleteImage,
    this.imagePath,
    this.thumbnailData,
  });
  final Function() onTap;
  final String? imagePath;
  final void Function()? deleteImage;
  final Uint8List? thumbnailData;

  @override
  State<CustomPickMediaWidget> createState() => _CustomPickMediaWidgetState();
}

class _CustomPickMediaWidgetState extends State<CustomPickMediaWidget> {
  @override
  void initState() {
    if (context.read<AssistantCubit>().selectedVideo != null) {
      context.read<AssistantCubit>().generateThumbnail();
    }
    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('Thumbnail generation imagePath ${widget.imagePath} thumbnailData ${widget.thumbnailData} videoThumbnailData ${context.read<AssistantCubit>().videoThumbnailData} 33 ${(context.read<AssistantCubit>().selectedVideo != null)} 77 ${context.read<AssistantCubit>().selectedVideo?.path}');
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
                context.read<AssistantCubit>().videoThumbnailData == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Stack(
                        children: [
                          Image.memory(
                              context
                                  .read<AssistantCubit>()
                                  .videoThumbnailData!,
                              errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.videocam,
                                size: 150.sp, color: AppColors.primary);
                          }, height: 150.h, fit: BoxFit.cover),
                          PositionedDirectional(
                              top: 3,
                              start: 3,
                              child: InkWell(
                                onTap: widget.deleteImage,
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
              else if (widget.thumbnailData != null)
                Stack(
                  children: [
                    Image.memory(widget.thumbnailData!,
                        errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.videocam,
                          size: 150.sp, color: AppColors.primary);
                    }, height: 150.h, fit: BoxFit.cover),
                    PositionedDirectional(
                        top: 3,
                        start: 3,
                        child: InkWell(
                          onTap: widget.deleteImage,
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
              else if (widget.imagePath != null && widget.imagePath!.isNotEmpty)
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.file(File(widget.imagePath ?? ''),
                        errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.videocam,
                          size: 150.sp, color: AppColors.primary);
                    }, height: 150.h, fit: BoxFit.cover),
                    PositionedDirectional(
                        top: 3,
                        start: 3,
                        child: InkWell(
                          onTap: widget.deleteImage,
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
                  onTap: widget.onTap,
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
