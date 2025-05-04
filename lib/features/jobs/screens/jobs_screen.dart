import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/widgets/custom_simple_appbar.dart';
import 'package:mawhebtak/features/jobs/cubit/jobs_cubit.dart';
import 'package:mawhebtak/features/jobs/cubit/jobs_state.dart';
import 'package:mawhebtak/features/jobs/screens/widgets/jop_widget.dart';
import '../../../core/exports.dart';
class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<JobsCubit>();
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<JobsCubit,JobsState>(
            builder: (context,state) {
              return Column(
                children: [
                  10.h.verticalSpace,
                  CustomSimpleAppbar(
                    title: 'jobs'.tr(),
                    isActionButton: true,
                  ),
                  Container(height: 10.h,color: AppColors.grayLite,),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) => Column(
                        children: [
                          const JobWidget(),
                          Container(height: 10.h,color: AppColors.grayLite,)
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
          ),
          Positioned(
            bottom: 50.h,
            right: 20.w,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.addNewJobRoute);
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
