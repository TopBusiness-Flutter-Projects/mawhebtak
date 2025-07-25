import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/preferences/hive/models/work_model.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_cubit.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_state.dart';
import 'package:mawhebtak/features/assistant/screens/add_new_work_screen.dart';
import '../../../core/exports.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/utils/check_login.dart';

class AssistantScreen extends StatefulWidget {
  const AssistantScreen({super.key});

  @override
  State<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<AssistantScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AssistantCubit>().getWorks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              10.h.verticalSpace,
              CustomSimpleAppbar(title: "assistant".tr()),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: AppColors.grayLite),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.h.verticalSpace,
                        Text("my_work".tr(),
                            style: getMediumStyle(fontSize: 16.sp)),
                        10.h.verticalSpace,
                        BlocBuilder<AssistantCubit, AssistantState>(
                          builder: (context, state) {
                            final cubit = context.watch<AssistantCubit>();

                            if (cubit.works == null) {
                              return const Expanded(
                                  child: Center(
                                      child: CircularProgressIndicator()));
                            }

                            if (cubit.works!.isEmpty) {
                              return Expanded(
                                  child:
                                  Center(
                                    child: Lottie.asset(
                                      'assets/animation_icons/search_no_data.json',
                                        height: 200,
                                        width: 200
                                    ),
                                  ));
                            }

                            return Expanded(
                              child: ListView.builder(
                                controller: cubit.scrollController,
                                itemCount: cubit.works!.length,
                                itemBuilder: (context, index) {
                                  final work = cubit.works![index];
                                  return WorkItemWidget(
                                    work: work,
                                    onEdit: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              AddNewWorkScreen(work: work),
                                        ),
                                      );
                                    },
                                    onDelete: () {
                                      cubit.deleteWork(context,
                                          workId: work.id ?? 0);
                                    },
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.workDetailsRoute,
                                        arguments: work,
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
        child: _buildAddButton(context),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final user = await Preferences.instance.getUserModel();
        if (user.data?.token == null) {
          checkLogin(context);
        } else {
          Navigator.pushNamed(context, Routes.addNewWorkRoute);
        }
      },
      child: Container(
        width: 60.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: const Center(child: Icon(Icons.add, color: Colors.white)),
      ),
    );
  }
}

class WorkItemWidget extends StatelessWidget {
  final WorkModel work;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const WorkItemWidget({
    super.key,
    required this.work,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(AppIcons.bagIcon),
            10.w.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(work.title ?? "",
                          style: getMediumStyle(fontSize: 14.sp)),
                      PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert,
                            size: 20.sp,
                            color: AppColors.darkGray.withOpacity(0.5)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'edit',
                            child: Text("edit".tr(),
                                style: getRegularStyle(fontSize: 14.sp)),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Text("delete".tr(),
                                style: getRegularStyle(fontSize: 14.sp)),
                          ),
                        ],
                        color: AppColors.grayLite,
                        onSelected: (value) {
                          if (value == 'edit') {
                            onEdit();
                          } else if (value == 'delete') {
                            onDelete();
                          }
                        },
                      ),
                    ],
                  ),
                  10.h.verticalSpace,
                  Text(
                    "${work.assistants?.length ?? 0} ${"assistants".tr()}",
                    style: getMediumStyle(
                        fontSize: 13.sp, color: AppColors.secondPrimary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
