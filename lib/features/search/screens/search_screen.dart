import 'package:easy_debounce/easy_debounce.dart';
import 'package:lottie/lottie.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/casting/cubit/casting_cubit.dart';
import 'package:mawhebtak/features/casting/cubit/casting_state.dart';
import 'package:mawhebtak/features/casting/screens/widgets/gigs_widgets.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_cubit.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_state.dart';
import 'package:mawhebtak/features/feeds/screens/widgets/time_line_list.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_top_event.dart';
import 'package:mawhebtak/features/jobs/cubit/jobs_cubit.dart';
import 'package:mawhebtak/features/jobs/cubit/jobs_state.dart';
import 'package:mawhebtak/features/jobs/screens/widgets/jop_widget.dart';
import 'package:mawhebtak/features/search/cubit/search_cubit.dart';
import '../../../core/widgets/show_loading_indicator.dart';
import '../../home/screens/widgets/custom_announcement_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int selectedTabIndex = 0;
  @override
  void initState() {
    context.read<SearchCubit>().getSearchAnnouncementData();
    super.initState();
  }

  final List<String> tabs = [
    "announcement".tr(),
    "gig".tr(),
    "jobs".tr(),
    "posts".tr(),
    "events".tr(),
  ];


  void onTabSelected(int index) {
    setState(() {
      selectedTabIndex = index;
    });
    context.read<SearchCubit>().searchController.clear();
    switch (index) {
      case 0:
        context.read<SearchCubit>().getSearchAnnouncementData();
        break;
      case 1:
        context.read<SearchCubit>().getSearchGigData();
        break;
      case 2:
        context.read<SearchCubit>().getSearchJobData();
        break;
      case 3:
        context.read<SearchCubit>().getSearchPostData();
        break;
      case 4:
        context.read<SearchCubit>().getSearchEventData();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
      var cubit = context.read<SearchCubit>();

      return Scaffold(
        body: Column(
          children: [
            CustomSimpleAppbar(
              title: "search".tr(),
            ),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _buildTabs(),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: cubit.searchController,
                      onChanged: (value) {
                        EasyDebounce.debounce(
                            'search',
                            const Duration(seconds: 1),
                                (){
                                  if (selectedTabIndex == 0) {
                                    cubit.getSearchAnnouncementData();
                                  } else if (selectedTabIndex == 1) {
                                    cubit.getSearchGigData();
                                  } else if (selectedTabIndex == 2) {
                                    cubit.getSearchJobData();
                                  } else if (selectedTabIndex == 3) {
                                    cubit.getSearchPostData();
                                  } else if (selectedTabIndex == 4) {
                                    cubit.getSearchEventData();
                                  }
                                }
                        );

                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        hintText: "search".tr(),
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Builder(
                      builder: (_) {
                        if (selectedTabIndex == 0) {
                          if (state is SearchAnnouncementDataStateLoading) {
                            return const Center(
                                child: CustomLoadingIndicator());
                          }
                          final data = cubit.announcementsModel?.data ?? [];
                          if (data.isEmpty) {
                            return Center(
                              child: Lottie.asset(
                                  'assets/animation_icons/search_no_data.json',
                                  height: 200,
                                  width: 200
                              ),
                            );
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) => SizedBox(
                              height: getSize(context) / 1,
                              child: CustomAnnouncementWidget(
                                index: index,
                                isMainWidget: true,
                                announcement: data[index],
                              ),
                            ),
                          );
                        } else if (selectedTabIndex == 1) {
                          if (state is SearchGigDataStateLoading) {
                            return const Center(
                                child: CustomLoadingIndicator());
                          }
                          final data = cubit.gigs?.data ?? [];
                          if (data.isEmpty) {
                            return Center(
                              child: Lottie.asset(
                                  'assets/animation_icons/search_no_data.json',
                                  height: 200,
                                  width: 200
                              ),
                            );
                          }
                          return BlocBuilder<CastingCubit, CastingState>(
                              builder: (context, state) {
                            var castingCubit = context.read<CastingCubit>();
                            return ListView.builder(
                              itemCount: data.length,
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              itemBuilder: (context, index) {
                                return GigsWidget(
                                  castingCubit: castingCubit,
                                  eventAndGigsModel: data[index],
                                );
                              },
                            );
                          });
                        } else if (selectedTabIndex == 2) {
                          if (state is SearchJobDataStateLoading) {
                            return const Center(
                                child: CustomLoadingIndicator());
                          }
                          final data = cubit.jobModel?.data ?? [];
                          if (data.isEmpty) {
                            return Center(
                              child: Lottie.asset(
                                  'assets/animation_icons/search_no_data.json',
                                  height: 200,
                                  width: 200
                              ),
                            );
                          }
                          return ListView.builder(
                            itemCount: data.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            itemBuilder: (context, index) {
                              return BlocBuilder<JobsCubit, JobsState>(
                                  builder: (context, state) {
                                var jobCubit = context.read<JobsCubit>();
                                return JobWidget(
                                  index: index,
                                  jobsCubit: jobCubit,
                                  userJop: cubit.jobModel?.data?[index],
                                );
                              });
                            },
                          );
                        } else if (selectedTabIndex == 3) {
                          if (state is SearchPostDataStateLoading) {
                            return const Center(
                                child: CustomLoadingIndicator());
                          }
                          final data = cubit.postsModel?.data ?? [];
                          if (data.isEmpty) {
                            return Center(
                              child: Lottie.asset(
                                  'assets/animation_icons/search_no_data.json',
                                  height: 200,
                                  width: 200
                              ),
                            );
                          }

                          return ListView.builder(
                            itemCount: data.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            itemBuilder: (context, index) {
                              return BlocBuilder<FeedsCubit, FeedsState>(
                                  builder: (context, state) {
                                var feedsCubit = context.read<FeedsCubit>();
                                return TimeLineList(
                                    postId: cubit.postsModel?.data?[index].id
                                            ?.toString() ??
                                        '',
                                    feedsCubit: feedsCubit,
                                    feeds: cubit.postsModel?.data?[index],
                                    index: index);
                              });
                            },
                          );
                        } else if (selectedTabIndex == 4) {
                          if (state is SearchEventDataStateLoading) {
                            return const Center(
                                child: CustomLoadingIndicator());
                          }
                          final data = cubit.eventsModel?.data ?? [];
                          if (data.isEmpty) {
                            return Center(
                              child: Lottie.asset(
                                  'assets/animation_icons/search_no_data.json',
                                  height: 200,
                                  width: 200
                              ),
                            );
                          }

                          return ListView.builder(
                            itemCount: data.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomTopEventList(
                                  topEvent: cubit.eventsModel?.data?[index],
                                  isAll: true,
                                ),
                              );
                            },
                          );
                        } else {
                          return const Center(child: Text("No tab selected."));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            tabs.length,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () => onTabSelected(index),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: selectedTabIndex == index
                        ? AppColors.primary
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selectedTabIndex == index
                          ? AppColors.primary
                          : Colors.grey.shade400,
                    ),
                  ),
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      color: selectedTabIndex == index
                          ? Colors.white
                          : Colors.black87,
                      fontWeight: FontWeight.w600,
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
