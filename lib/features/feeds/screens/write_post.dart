import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/core/widgets/custom_container_with_shadow.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_cubit.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_state.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/image_view_file.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/video_from_file_screen.dart';
import 'package:mawhebtak/features/home/screens/widgets/follow_button.dart';
import 'package:video_player/video_player.dart';
import '../../../core/exports.dart';
import '../../auth/login/data/models/login_model.dart';
import '../../events/screens/widgets/custom_apply_app_bar.dart';

class WritePost extends StatefulWidget {
  const WritePost({super.key});

  @override
  State<WritePost> createState() => _WritePostState();
}

class _WritePostState extends State<WritePost> {
  LoginModel? loginModel;
  @override
  void initState() {
    Preferences.instance.getUserModel().then((value) {
      setState(() {
        loginModel = value;
      });
    });
    context.read<FeedsCubit>().loadUserFromPreferences();
    super.initState();
  }

  VideoPlayerController? _controller;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<FeedsCubit>().clearDataAndBack(context);
        return Future.value(false);
      },
      child: Scaffold(
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
                            child: loginModel?.data?.image == null
                                ? Image.asset(ImageAssets.profileImage)
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        loginModel?.data?.image ?? ""),
                                  ),
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter_post_title'.tr();
                          }
                          return null;
                        },
                        controller: cubit.bodyController,
                        hintText: "what_do_you_want_to_write".tr(),
                        maxLines: 6,
                        isMessage: true,
                      ),
                      SizedBox(height: getHeightSize(context) / 25),
                      CustomContainerWithShadow(
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
                              SizedBox(
                                height: 80,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: (cubit.myImages?.length ?? 0) + 1,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 10),
                                  itemBuilder: (context, index) {
                                    if (index ==
                                        (cubit.myImages?.length ?? 0)) {
                                      return GestureDetector(
                                        onTap: () {
                                          cubit.pickMultiImage();
                                        },
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.grey[300],
                                          ),
                                          child: const Icon(Icons.add,
                                              size: 30, color: Colors.black54),
                                        ),
                                      );
                                    }

                                    return Stack(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ImageFileView(
                                                            image: cubit
                                                                .myImages![
                                                                    index]
                                                                .path)));
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                                                cubit.deleteImage(File(cubit
                                                    .myImages![index].path));
                                              });
                                            },
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.black45,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(Icons.close,
                                                  color: Colors.white,
                                                  size: 18),
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
                      SizedBox(height: 20.h),
                      CustomContainerWithShadow(
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
                              SizedBox(
                                height: 80,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: (cubit.validVideos.length) + 1,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 10),
                                  itemBuilder: (context, index) {
                                    if (index == (cubit.validVideos.length)) {
                                      return GestureDetector(
                                        onTap: () {
                                          cubit.pickMultipleVideos(context);
                                        },
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Colors.grey[300],
                                          ),
                                          child: const Icon(Icons.add,
                                              size: 30, color: Colors.black54),
                                        ),
                                      );
                                    }
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VideoPlayerScreenFile(
                                                      videoFile: File(cubit
                                                          .validVideos[index]
                                                          .path),
                                                    )));
                                      },
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Container(
                                              width: 80,
                                              height: 80,
                                              color: Colors.black12,
                                              child: const Center(
                                                child: Icon(
                                                    Icons.play_circle_fill,
                                                    size: 40,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  cubit.deleteVideo(File(cubit
                                                      .validVideos[index]
                                                      .path));
                                                });
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.black45,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(Icons.close,
                                                    color: Colors.white,
                                                    size: 18),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
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
                                                .pushNamedAndRemoveUntil(
                                                    Routes.loginRoute,
                                                    (route) => false);
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
                                  final hasText = cubit.bodyController.text
                                      .trim()
                                      .isNotEmpty;
                                  final hasImages = cubit.myImages != null &&
                                      cubit.myImages!.isNotEmpty;
                                  final hasVideos =
                                      cubit.validVideos.isNotEmpty;
                                  return Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ImageFileView(
                                                          image: cubit
                                                              .myImages![index]
                                                              .path)));
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                              cubit.deleteImage(File(
                                                  cubit.myImages![index].path));
                                            });
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.black45,
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(Icons.close,
                                                color: Colors.white, size: 18),
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
                    SizedBox(height: 20.h),
                    CustomContainerWithShadow(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            SizedBox(
                              height: 80,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: (cubit.validVideos.length) + 1,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(width: 10),
                                itemBuilder: (context, index) {
                                  if (index == (cubit.validVideos.length)) {
                                    return GestureDetector(
                                      onTap: () {
                                        cubit.pickMultipleVideos(context);
                                      },
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.grey[300],
                                        ),
                                        child: const Icon(Icons.add,
                                            size: 30, color: Colors.black54),
                                      ),
                                    );
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VideoPlayerScreenFile(
                                                    videoFile: File(cubit
                                                        .validVideos[index]
                                                        .path),
                                                  )));
                                    },
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Container(
                                            width: 80,
                                            height: 80,
                                            color: Colors.black12,
                                            child: const Center(
                                              child: Icon(
                                                  Icons.play_circle_fill,
                                                  size: 40,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                cubit.deleteVideo(File(cubit
                                                    .validVideos[index].path));
                                              });
                                            },
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.black45,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(Icons.close,
                                                  color: Colors.white,
                                                  size: 18),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
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
                                    insetPadding: EdgeInsets.zero,
                                    title: Text("alert".tr()),
                                    content: Text("must_login".tr()),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  Routes.loginRoute,
                                                  (route) => false);
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
                                final hasText =
                                    cubit.bodyController.text.trim().isNotEmpty;
                                final hasImages = cubit.myImages != null &&
                                    cubit.myImages!.isNotEmpty;
                                final hasVideos = cubit.validVideos.isNotEmpty;

                                  if (!hasText && !hasImages && !hasVideos) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text("alert".tr()),
                                        content: Text(
                                            "please_add_text_or_media".tr()),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: Text("ok".tr()),
                                          ),
                                        ],
                                      ),
                                    );
                                    return;
                                  }
                                if (!hasText && !hasImages && !hasVideos) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      insetPadding: EdgeInsets.zero,
                                      title: Text("alert".tr()),
                                      content:
                                          Text("please_add_text_or_media".tr()),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: Text("ok".tr()),
                                        ),
                                      ],
                                    ),
                                  );
                                  return;
                                }

                                  cubit.addPost(context: context);
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
      ),
    );
  }
}
