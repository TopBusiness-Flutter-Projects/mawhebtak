import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/preferences/hive/models/work_model.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_cubit.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_state.dart';

import '../../../core/exports.dart';

class WorkDetailsScreen extends StatefulWidget {
  const WorkDetailsScreen({super.key, this.work});
  final Work? work;
  @override
  State<WorkDetailsScreen> createState() => _WorkDetailsScreenState();
}

class _WorkDetailsScreenState extends State<WorkDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<AssistantCubit>()
        .getAllAssistantFromWork(widget.work?.id ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AssistantCubit>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                10.h.verticalSpace,
                CustomSimpleAppbar(title: "assistant".tr()),
                BlocBuilder<AssistantCubit, AssistantState>(
                  builder: (context, state) {
                    final cubit = context.read<AssistantCubit>();

                    if (cubit.assistants?.length == 0) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            "no_assistant_found".tr(),
                            style: getRegularStyle(
                                fontSize: 18.sp, color: AppColors.blackLite),
                          ),
                        ),
                      );
                    }

                    return Expanded(
                      child: ListView.builder(
                        controller: cubit.scrollController,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        itemCount: cubit.assistants!.length,
                        itemBuilder: (context, index) {
                          final work = cubit.assistants![index];

                          return Container(
                            margin: EdgeInsets.only(bottom: 10.h),
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              work.title ?? "",
                              style: getRegularStyle(fontSize: 16.sp),
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              ],
            ),
            // زر الإضافة
            Positioned(
              bottom: 50.h,
              right: 20.w,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.addAssistantRoute);
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
      ),
    );
  }
}
