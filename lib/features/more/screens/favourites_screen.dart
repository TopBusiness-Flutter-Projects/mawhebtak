import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/announcement/cubit/announcement_cubit.dart';
import 'package:mawhebtak/features/jobs/cubit/jobs_cubit.dart';
import 'package:mawhebtak/features/jobs/cubit/jobs_state.dart';
import 'package:mawhebtak/features/jobs/screens/widgets/jop_widget.dart';
import 'package:mawhebtak/features/more/cubit/more_cubit.dart';
import 'package:mawhebtak/features/more/cubit/more_state.dart';
import '../../../core/widgets/show_loading_indicator.dart';
import '../../home/screens/widgets/custom_announcement_widget.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  int selectedTabIndex = 0;
  @override
  void initState() {
    context.read<MoreCubit>().getAnnounceFavouritesData();
    context.read<MoreCubit>().getUserJobFavouritesData();
    super.initState();
  }

  final List<String> tabs = ["announcement".tr(), "jobs".tr()];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobsCubit, JobsState>(builder: (context, jobState) {
      return BlocBuilder<AnnouncementCubit, AnnouncementState>(
          builder: (context, announceState) {
        return Scaffold(
          body: Column(
            children: [
              CustomSimpleAppbar(
                title: "favourites".tr(),
              ),
              BlocBuilder<MoreCubit, MoreState>(builder: (context, state) {
                var cubit = context.read<MoreCubit>();
                return Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      _buildTabs(),
                      const SizedBox(height: 20),
                      (selectedTabIndex == 0)
                          ? Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  (state is AnnounceFavouritesDataStateLoading)
                                      ? const Expanded(
                                          child: Center(
                                              child: CustomLoadingIndicator()))
                                      : Expanded(
                                          child:
                                              (cubit.announcementFavouriteModel
                                                          ?.data?.length ==
                                                      0)
                                                  ? Center(
                                                      child:
                                                          Text("no_data".tr()))
                                                  : ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: cubit
                                                              .announcementFavouriteModel
                                                              ?.data
                                                              ?.length ??
                                                          0,
                                                      itemBuilder:
                                                          (context, index) {
                                                        var announcement = cubit
                                                            .announcementFavouriteModel
                                                            ?.data?[index];

                                                        return SizedBox(
                                                          height:
                                                              getSize(context) /
                                                                  1,
                                                          child:
                                                              CustomAnnouncementWidget(
                                                            index: index,
                                                            isMainWidget: true,
                                                            announcement:
                                                                announcement,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                        )
                                ],
                              ),
                            )
                          : (state is GetUserJopStateLoading)
                              ? const Expanded(
                                  child: Center(
                                  child: CustomLoadingIndicator(),
                                ))
                              : Expanded(
                                  child: (cubit.userJobFavouriteModel?.data
                                              ?.length ==
                                          0)
                                      ? Center(child: Text("no_data".tr()))
                                      : BlocBuilder<JobsCubit, JobsState>(
                                          builder: (context, state) {
                                          return ListView.builder(
                                            itemCount: cubit
                                                    .userJobFavouriteModel
                                                    ?.data
                                                    ?.length ??
                                                0,
                                            itemBuilder: (context, index) =>
                                                Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10.h),
                                                  child: JobWidget(
                                                    index: index,
                                                    jobsCubit: context
                                                        .read<JobsCubit>(),
                                                    userJop: cubit
                                                        .userJobFavouriteModel
                                                        ?.data?[index],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                )
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      });
    });
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: List.generate(
          tabs.length,
          (index) => Expanded(
            // Correct placement
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedTabIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 8.0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: selectedTabIndex == index
                      ? AppColors.primary
                      : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    tabs[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: selectedTabIndex == index
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
