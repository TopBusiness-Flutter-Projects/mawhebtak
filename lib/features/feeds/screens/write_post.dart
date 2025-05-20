// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:mawhebtak/core/widgets/custom_container_with_shadow.dart';
// import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
// import 'package:mawhebtak/features/feeds/cubit/feeds_cubit.dart';
// import 'package:mawhebtak/features/feeds/cubit/feeds_state.dart';
// import 'package:mawhebtak/features/home/screens/widgets/follow_button.dart';
// import '../../../core/exports.dart';
// import '../../events/screens/widgets/custom_apply_app_bar.dart';
//
// class WritePost extends StatelessWidget {
//   const WritePost({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<FeedsCubit, FeedsState>(builder: (context, state) {
//         var cubit = context.read<FeedsCubit>();
//         return Column(
//           children: [
//             //app bar
//             Padding(
//               padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
//               child: CustomAppBarWithClearWidget(
//                 title: "share_post".tr(),
//               ),
//             ),
//             //body
//             Padding(
//               padding: EdgeInsets.only(top: 10.0.h, left: 20.w, right: 20.w),
//               child: Column(
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         height: 40.h,
//                         width: 40.w,
//                         child: Image.asset(ImageAssets.profileImage),
//                       ),
//                       SizedBox(width: 8.w),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           AutoSizeText("Ahmed Mokhtar",
//                               style: getMediumStyle(fontSize: 16.sp)),
//                         ],
//                       ),
//                     ],
//                   ),
//                   5.verticalSpace,
//                   CustomTextField(
//                     controller: cubit.bodyController,
//                     hintText: "what_do_you_want_to_write".tr(),
//                     maxLines: 6,
//                     isMessage: true,
//                   ),
//                   SizedBox(height: getHeightSize(context) / 25),
//                   CustomContainerWithShadow(
//                     child: Padding(
//                       padding: EdgeInsets.all(20.0.w),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SvgPicture.asset(AppIcons.photoIcon),
//                           SizedBox(
//                             width: 10.w,
//                           ),
//                           Text(
//                             "upload_photo".tr(),
//                             style: getMediumStyle(fontSize: 14.sp),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   CustomContainerWithShadow(
//                     child: Padding(
//                       padding: EdgeInsets.all(20.0.w),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SvgPicture.asset(AppIcons.videoUploadIcon),
//                           SizedBox(
//                             width: 10.w,
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "upload_video".tr(),
//                                 style: getMediumStyle(fontSize: 14.sp),
//                               ),
//                               Text(
//                                 "The video should be max 4 MB".tr(),
//                                 style: getRegularStyle(
//                                     fontSize: 14.sp, color: AppColors.grayAfaf),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: getHeightSize(context) / 25),
//                   (state is AddPostStateLoading)
//                       ? const CustomLoadingIndicator()
//                       : CustomContainerButton(
//                           onTap: () {
//                             cubit.addPost(context: context);
//                           },
//                           title: "post".tr(),
//                           color: AppColors.primary,
//                           height: 48.h,
//                         )
//                 ],
//               ),
//             )
//           ],
//         );
//       }),
//     );
//   }
// }
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/widgets/custom_container_with_shadow.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_cubit.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_state.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/image_view_file.dart';
import 'package:mawhebtak/features/home/screens/widgets/follow_button.dart';
import '../../../core/exports.dart';
import '../../events/screens/widgets/custom_apply_app_bar.dart';

class WritePost extends StatefulWidget {
  const WritePost({super.key});

  @override
  State<WritePost> createState() => _WritePostState();
}

class _WritePostState extends State<WritePost> {
  @override
  void initState() {
    context.read<FeedsCubit>().getUserFromPreferences();
    context.read<FeedsCubit>().loadUserFromPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FeedsCubit, FeedsState>(
        builder: (context, state) {
          var cubit = context.read<FeedsCubit>();
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                child: CustomAppBarWithClearWidget(
                  title: "share_post".tr(),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40.h,
                          width: 40.w,
                          child: Image.asset(ImageAssets.profileImage),
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              cubit.user?.data?.name ?? "",
                              style: getMediumStyle(fontSize: 16.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                    5.verticalSpace,
                    CustomTextField(
                      controller: cubit.bodyController,
                      hintText: "what_do_you_want_to_write".tr(),
                      maxLines: 6,
                      isMessage: true,
                    ),
                    SizedBox(height: getHeightSize(context) / 25),
                    GestureDetector(
                      onTap: () => cubit.pickMultiImage(),
                      child: CustomContainerWithShadow(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(AppIcons.photoIcon),
                                  const SizedBox(width: 10),
                                  Text("upload_photo".tr(),
                                      style: getMediumStyle(fontSize: 14)),
                                ],
                              ),
                              const SizedBox(height: 10),
                              if (cubit.myImages != null && cubit.myImages!.isNotEmpty)
                                SizedBox(
                                  height: 80,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: cubit.myImages?.length ?? 0,
                                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                                    itemBuilder: (context, index) {
                                      return Stack(
                                        children: [
                                          GestureDetector(
                                            onTap:(){
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ImageFileView(
                                                              image: File(
                                                                  cubit.myImages![index].path))));
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: Image.file(
                                                File(cubit.myImages![index].path),
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                   cubit.deleteImage(File(cubit.myImages![index].path));
                                                });
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.black45,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(Icons.close, color: Colors.white, size: 18),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                )


                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () => cubit.pickVideos(),
                      child: CustomContainerWithShadow(
                        child: Padding(
                          padding: EdgeInsets.all(20.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(AppIcons.videoUploadIcon),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("upload_video".tr(),
                                          style: getMediumStyle(fontSize: 14)),
                                      Text("The video should be max 4 MB".tr(),
                                          style: getRegularStyle(
                                              fontSize: 14,
                                              color: AppColors.grayAfaf)),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              if (cubit.selectedVideos.isNotEmpty)
                                SizedBox(
                                  height: 80,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: cubit.selectedVideos.length,
                                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                                    itemBuilder: (context, index) {
                                      return Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Container(
                                              width: 80,
                                              height: 80,
                                              color: Colors.black12,
                                              child: const Center(
                                                child: Icon(Icons.play_circle_fill, size: 40, color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  cubit.selectedVideos.removeAt(index);
                                                });
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.black45,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(Icons.close, color: Colors.white, size: 18),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                )


                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: getHeightSize(context) / 25),
                    (state is AddPostStateLoading)
                        ? const CustomLoadingIndicator()
                        : CustomContainerButton(
                            onTap: () {
                              if (cubit.user?.data?.token == null) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("alert".tr()),
                                    content: Text("must_login".tr()),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context)
                                              .pushNamed(Routes.loginRoute);
                                        },
                                        child: Text("login".tr()),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("cancel".tr()),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                if (cubit.bodyController.text == '') {
                                  errorGetBar("fill_the_data".tr());
                                } else {
                                  cubit.addPost(context: context);
                                }
                              }
                            },
                            title: "post".tr(),
                            color: AppColors.primary,
                            height: 48.h,
                          ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
