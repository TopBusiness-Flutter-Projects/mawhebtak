import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/announcement/cubit/announcement_cubit.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_announcement_widget.dart';

class AllAnnouncementsScreen extends StatefulWidget {
  const AllAnnouncementsScreen({super.key});

  @override
  State<AllAnnouncementsScreen> createState() => _AllAnnouncementsScreenState();
}

class _AllAnnouncementsScreenState extends State<AllAnnouncementsScreen> {
  late final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    context
        .read<AnnouncementCubit>()
        .announcementsData(page: '1', isGetMore: false, orderBy: "desc");
    final announcement = context.read<AnnouncementCubit>().announcements;
    if (announcement?.data != null) {
      print("Data length: ${announcement!.data!.length}");
    }
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (context.read<AnnouncementCubit>().announcements?.links?.next !=
          null) {
        Uri uri = Uri.parse(
            context.read<AnnouncementCubit>().announcements?.links?.next ?? "");
        String? page = uri.queryParameters['page'];
        context
            .read<AnnouncementCubit>()
            .announcementsData(page: page ?? '1', isGetMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AnnouncementCubit, AnnouncementState>(
          builder: (context, state) {
        var announcementsData = context.read<AnnouncementCubit>().announcements;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSimpleAppbar(
              title: 'announcement'.tr(),
              isActionButton: true,
              filterType: 'announcement',
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (state is AnnouncementsStateLoading)
                      ? const Expanded(
                          child: Center(
                            child: CustomLoadingIndicator(),
                          ),
                        )
                      : Expanded(
                          child: Padding(
                          padding: EdgeInsets.only(left: 8.w, right: 8.w),
                          child: GridView.builder(
                            shrinkWrap: true,
                            controller: scrollController,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    mainAxisSpacing: 8.h,
                                    crossAxisSpacing: 8.w,
                                    childAspectRatio: 0.7),
                            itemBuilder: (context, index) =>
                                CustomAnnouncementWidget(
                              announcement: announcementsData?.data?[index],
                              isLeftPadding: index == 0 ? true : false,
                              isRightPadding: index ==
                                      (announcementsData?.data?.length ?? 1) - 1
                                  ? true
                                  : false,
                            ),
                            itemCount: announcementsData?.data?.length ?? 0,
                          ),
                        )),
                  if (state is AnnouncementsStateLoadingMore)
                    const CustomLoadingIndicator(),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
