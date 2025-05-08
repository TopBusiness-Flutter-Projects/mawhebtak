import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_cubit.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_state.dart';
import 'package:mawhebtak/features/assistant/screens/add_new_work_screen.dart';
import '../../../core/exports.dart';

class AssistantScreen extends StatefulWidget {
  const AssistantScreen({super.key});

  @override
  State<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<AssistantScreen> {
  @override
  void initState() {
    context.read<AssistantCubit>().getAllWorks();
    print("the works ${context.read<AssistantCubit>().getAllWorks()}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AssistantCubit>();
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              10.h.verticalSpace,
              CustomSimpleAppbar(title: "assistant".tr()),
              BlocBuilder<AssistantCubit, AssistantState>(
                builder: (context, state) {
                  return Expanded(
                    child: Container(
                      decoration: BoxDecoration(color: AppColors.grayLite),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.w, left: 20.w, right: 20.w),
                            child: Text("my_work".tr(),
                                style: getMediumStyle(fontSize: 16.sp)),
                          ),
                          cubit.works!.isEmpty
                              ? Expanded(child: Center(child: Text("no_works_yet".tr())))
                              : Expanded(
                                  child: ListView.builder(
                                    controller: cubit.scrollController,
                                    shrinkWrap: true,
                                    itemCount: cubit.works?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      final work = cubit.works?[index];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              Routes.workDetailsRoute,arguments: work);
                                        },
                                        child: Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 10.h),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppColors.white),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                bottom: 10.h,
                                                left: 20.w,
                                                right: 20.w,
                                                top: 10.h,
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SvgPicture.asset(
                                                      AppIcons.bagIcon),
                                                  10.w.horizontalSpace,
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      work?.title ??
                                                                          "",
                                                                      style: getMediumStyle(
                                                                          fontSize:
                                                                              14.sp),
                                                                    ),
                                                                    10.h.verticalSpace,
                                                                    Text(
                                                                      work?.assistants
                                                                              ?.length
                                                                              .toString() ??
                                                                          "",
                                                                      style:
                                                                          getMediumStyle(
                                                                        fontSize:
                                                                            13.sp,
                                                                        color: AppColors
                                                                            .secondPrimary,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            PopupMenuButton<
                                                                    String>(
                                                                icon: Icon(
                                                                  Icons
                                                                      .more_vert,
                                                                  size: 20.sp,
                                                                  color: AppColors
                                                                      .darkGray
                                                                      .withOpacity(
                                                                          0.5),
                                                                ),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.r),
                                                                ),
                                                                itemBuilder:
                                                                    (context) =>
                                                                        [
                                                                          PopupMenuItem(
                                                                            value:
                                                                                'edit',
                                                                            child: Text("modify".tr(),
                                                                                style: getRegularStyle(
                                                                                  fontSize: 14.sp,
                                                                                )),
                                                                          ),
                                                                          PopupMenuItem(
                                                                            value:
                                                                                'delete',
                                                                            child:
                                                                                Text("delete".tr(), style: getRegularStyle(fontSize: 14.sp)),
                                                                          ),
                                                                        ],
                                                                color: AppColors
                                                                    .grayLite,
                                                                onSelected:
                                                                    (value) {
                                                                  if (value ==
                                                                      'edit') {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (_) =>
                                                                                AddNewWorkScreen(work: work),
                                                                      ),
                                                                    );
                                                                  } else if (value ==
                                                                      'delete') {
                                                                    cubit.deleteWork(
                                                                        context,
                                                                        workId:
                                                                            work?.id ??
                                                                                0);
                                                                  }
                                                                }),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          Positioned(
            bottom: 50.h,
            right: 20.w,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.addNewWorkRoute);
              },
              child: Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
