import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/home/cubits/top_events_cubit/top_events_cubit.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_top_event.dart';
import '../../../core/exports.dart';

class TopEventsScreen extends StatefulWidget {
  const TopEventsScreen({super.key});

  @override
  State<TopEventsScreen> createState() => _TopEventsScreenState();
}

class _TopEventsScreenState extends State<TopEventsScreen> {
  late final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    context.read<TopEventsCubit>().topEventsData(page: '1', isGetMore: false);
    super.initState();
  }

  _scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (context.read<TopEventsCubit>().topEvents?.links?.next != null) {
        Uri uri = Uri.parse(
            context.read<TopEventsCubit>().topEvents?.links?.next ?? "");
        String? page = uri.queryParameters['page'];
        context
            .read<TopEventsCubit>()
            .topEventsData(page: page ?? '1', isGetMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopEventsCubit, TopEventsState>(
      builder: (BuildContext context, state) {
        var cubit = context.read<TopEventsCubit>();
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomSimpleAppbar(
                title: 'events'.tr(),
                isActionButton: true,
                filterType: 'event',
              ),
              switch (state) {
                TopEventsStateError() => Expanded(
                    child: Center(child: Text(state.errorMessage.toString()))),
                TopEventsStateLoaded() ||
                SeeAllEventStateLoadingMore() =>
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                      child: Center(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            cubit.topEventsData(page: '1', isGetMore: false);
                          },
                          child: ListView.separated(
                            controller: scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: context
                                    .read<TopEventsCubit>()
                                    .topEvents
                                    ?.data
                                    ?.length ??
                                0,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return CustomTopEventList(
                                topEvent: context
                                    .read<TopEventsCubit>()
                                    .topEvents
                                    ?.data?[index],
                                isAll: true,
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 10.h,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                SeeAllEventStateLoading() => const Expanded(
                    child: Center(
                      child: CustomLoadingIndicator(),
                    ),
                  ),
              },
              if (state is SeeAllEventStateLoadingMore)
                const CustomLoadingIndicator(),
            ],
          ),
        );
      },
    );
  }
}
