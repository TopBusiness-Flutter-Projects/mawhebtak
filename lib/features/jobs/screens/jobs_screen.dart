import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/jobs/cubit/jobs_cubit.dart';
import 'package:mawhebtak/features/jobs/cubit/jobs_state.dart';
import 'package:mawhebtak/features/jobs/screens/widgets/jop_widget.dart';
import '../../../core/exports.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/utils/check_login.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  late final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // if (context.read<JobsCubit>().userJopModel == null) {
    //   context.read<JobsCubit>().getUserJopData(page: '1');
    // }
    context.read<JobsCubit>().getUserJopData(page: '1');
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (context.read<JobsCubit>().userJopModel?.links?.next != null) {
        Uri uri = Uri.parse(
            context.read<JobsCubit>().userJopModel?.links?.next ?? "");
        String? page = uri.queryParameters['page'];
        context
            .read<JobsCubit>()
            .getUserJopData(page: page ?? '1', isGetMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<JobsCubit, JobsState>(builder: (context, state) {
            var jopUserData = context.read<JobsCubit>().userJopModel?.data;
            return Column(
              children: [
                10.h.verticalSpace,
                CustomSimpleAppbar(
                  title: 'jobs'.tr(),
                  isActionButton: true,
                ),
                Container(
                  height: 10.h,
                  color: AppColors.grayLite,
                ),
                (state is GetUserJopStateLoading)
                    ? const Expanded(
                        child: Center(
                        child: CustomLoadingIndicator(),
                      ))
                    : (jopUserData?.length == 0)
                        ? const Expanded(child: Center(child: Text("no_data")))
                        : Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                context
                                    .read<JobsCubit>()
                                    .getUserJopData(page: '1');
                              },
                              child: ListView.builder(
                                controller: scrollController,
                                itemCount: jopUserData?.length ?? 0,
                                itemBuilder: (context, index) => Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10.h),
                                      child: JobWidget(
                                        index: index,
                                        jobsCubit: context.read<JobsCubit>(),
                                        userJop: context
                                            .read<JobsCubit>()
                                            .userJopModel
                                            ?.data?[index],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                if (state is GetUserJopStateLoadingMore)
                  const CustomLoadingIndicator(),
              ],
            );
          }),
          Positioned(
            bottom: 50.h,
            right: 20.w,
            child: GestureDetector(
              onTap: () async {
                final user = await Preferences.instance.getUserModel();
                if (user.data?.token == null) {
                  checkLogin(context);
                } else {
                  Navigator.pushNamed(context, Routes.addNewJobRoute);
                }
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
