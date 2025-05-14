import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/home/cubits/announcements_cubit/announcements_cubit.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_announcement_widget.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  @override
  late final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (context.read<AnnouncementsCubit>().announcements?.links?.next != null) {
        Uri uri = Uri.parse(
            context.read<AnnouncementsCubit>().announcements?.links?.next ?? "");
        String? page = uri.queryParameters['page'];
        context
            .read<AnnouncementsCubit>()
            .announcementsData(page: page ?? '1', isGetMore: true);
      }
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AnnouncementsCubit, AnnouncementsState>(
          builder: (context, state) {
        var announcementsData = context.read<AnnouncementsCubit>().announcements;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSimpleAppbar(
              title: 'announcement'.tr(),
              isActionButton: true,
            ),
            switch (state) {
              AnnouncementsStateLoading() => const Expanded(
                  child: Center(
                    child: CustomLoadingIndicator(),
                  ),
                ),
              AnnouncementsStateError() => Expanded(
                  child: Center(child: Text(state.errorMessage.toString()))),
              AnnouncementsStateLoaded()  || AnnouncementsStateLoadingMore()=> Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 8.w, right: 8.w),
                  child: ListView.builder(
                    controller: scrollController,
                   shrinkWrap: true,
                    itemBuilder: (context, index) => CustomAnnouncementWidget(
                      announcement: announcementsData?.data?[index],
                      isLeftPadding: index == 0 ? true : false,
                      isRightPadding:
                          index == (announcementsData?.data?.length ?? 1) - 1
                              ? true
                              : false,
                    ),
                    itemCount: announcementsData?.data?.length ?? 0,
                  ),
                )),

            },
            if (state is AnnouncementsStateLoadingMore)
              const CustomLoadingIndicator(),
          ],
        );
      }),
    );
  }
}
