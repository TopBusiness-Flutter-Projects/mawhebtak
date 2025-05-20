import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_cubit.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_state.dart';
import '../../../core/exports.dart';
import '../../home/screens/widgets/custom_app_bar_row.dart';
import 'widgets/time_line_list.dart';
import 'widgets/what_do_you_want.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  late final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (context.read<FeedsCubit>().posts?.links?.next != null) {
        Uri uri =
            Uri.parse(context.read<FeedsCubit>().posts?.links?.next ?? "");
        String? page = uri.queryParameters['page'];
        context
            .read<FeedsCubit>()
            .postsData(page: page ?? '1', isGetMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FeedsCubit, FeedsState>(builder: (context, state) {
        var feeds = context.read<FeedsCubit>().posts;
        var feedsCubit = context.read<FeedsCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40.h),
              child: CustomAppBarRow(
                colorTextFromSearchTextField:
                    AppColors.darkGray.withOpacity(0.3),
                backgroundColorTextFieldSearch: AppColors.grayLite,
                isMore: true,
                colorSearchIcon: AppColors.secondPrimary,
                backgroundNotification: AppColors.primary,
              ),
            ),
            Container(
              color: AppColors.grayLite,
              height: getHeightSize(context) / 50,
            ),
            const WhatDoYouWant(),
            10.h.verticalSpace,
            if (state is FeedsStateLoading) ...[
              const Expanded(
                child: Center(
                  child: CustomLoadingIndicator(),
                ),
              ),
            ] else if (state is FeedsStateLoaded ||
                state is FeedsStateLoadingMore ||
                feeds != null) ...[
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: feeds?.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return TimeLineList(
                        postId: feeds!.data![index].id.toString(),
                        feedsCubit: feedsCubit,
                        feeds: feeds.data![index],
                        index: index);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 15.h,
                    );
                  },
                ),
              ),
            ] else if (state is FeedsStateError) ...[
              Expanded(
                child: Center(
                  child: Text(state.errorMessage),
                ),
              ),
            ],
          ],
        );
      }),
    );
  }
}
