import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/home/cubits/request_gigs_cubit/request_gigs_cubit.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_request_gigs.dart';
import '../../../core/widgets/show_loading_indicator.dart';

class RequestGigsScreen extends StatefulWidget {
  const RequestGigsScreen({super.key});

  @override
  State<RequestGigsScreen> createState() => _RequestGigsScreenState();
}

class _RequestGigsScreenState extends State<RequestGigsScreen> {
  late final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    context.read<RequestGigsCubit>().requestGigsData(
          page: '1',
          isGetMore: false,
        );

    scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (context.read<RequestGigsCubit>().requestGigs?.links?.next != null) {
        Uri uri = Uri.parse(
            context.read<RequestGigsCubit>().requestGigs?.links?.next ?? "");
        String? page = uri.queryParameters['page'];
        context
            .read<RequestGigsCubit>()
            .requestGigsData(page: page ?? '1', isGetMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RequestGigsCubit, RequestGigsState>(
          builder: (context, state) {
        var requestGigs = context.read<RequestGigsCubit>().requestGigs;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSimpleAppbar(
              title: 'request_gigs'.tr(),
              isActionButton: true,
              filterType: 'casting',
            ),
            switch (state) {
              RequestGigsStateLoading() => const Expanded(
                  child: Center(
                    child: CustomLoadingIndicator(),
                  ),
                ),
              RequestGigsStateError() => Expanded(
                  child: Center(child: Text(state.errorMessage.toString()))),
              RequestGigsStateLoaded() ||
              RequestGigsStateLoadingMore() =>
                Expanded(
                    child: GridView.builder(
                  controller: scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisSpacing: 10),
                  itemBuilder: (context, index) => CustomRequestGigsList(
                    requestGigs: requestGigs?.data?[index],
                    isLeftPadding: index == 0 ? true : false,
                    isRightPadding:
                        index == (requestGigs?.data?.length ?? 1) - 1
                            ? true
                            : false,
                  ),
                  itemCount: requestGigs?.data?.length ?? 0,
                )),
            },
            if (state is RequestGigsStateLoadingMore)
              const CustomLoadingIndicator(),
          ],
        );
      }),
    );
  }
}
