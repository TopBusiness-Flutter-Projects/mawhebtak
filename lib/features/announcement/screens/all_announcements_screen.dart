import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/announcement/cubit/announcement_cubit.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_announcement_widget.dart';

import '../../../core/utils/filter.dart';

class AllAnnouncementsScreen extends StatefulWidget {
  const AllAnnouncementsScreen({super.key});

  @override
  State<AllAnnouncementsScreen> createState() => _AllAnnouncementsScreenState();
}

class _AllAnnouncementsScreenState extends State<AllAnnouncementsScreen> {
  late final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    context.read<AnnouncementCubit>().announcementsData(page: '1', orderBy: selctedFilterOption?.key);
    scrollController.addListener(_scrollListener);
    context.read<AnnouncementCubit>().loadUserFromPreferences();
    super.initState();
  }

  _scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (context.read<AnnouncementCubit>().announcements?.links?.next !=
          null) {
        Uri uri = Uri.parse(
            context.read<AnnouncementCubit>().announcements?.links?.next ?? "");
        String? page = uri.queryParameters['page'];
        context.read<AnnouncementCubit>().announcementsData(
            page: page ?? '1',
            isGetMore: true,
            orderBy: selctedFilterOption?.key);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomSimpleAppbar(
              title: 'announcements'.tr(),
              isActionButton: true,
              filterType: 'announcements',
            ),
            (state is AnnouncementsStateLoading)?
             const Expanded(child: Center(child: CustomLoadingIndicator())):
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                shrinkWrap: true,
                itemCount: announcementsData?.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return (announcementsData?.data?[index] == 0 || announcementsData?.data?.length ==[])
                      ? Expanded(child: Text("no_data".tr(),style: TextStyle(
                    color: AppColors.black,
                  ),))
                      : SizedBox(
                        height: getSize(context)/1,
                        child: CustomAnnouncementWidget(
                          index: index,
                            isMainWidget: true,
                            announcement: announcementsData?.data?[index],
                          ),
                      );
                },
              ),
            ),
            if (state is AnnouncementsStateLoadingMore)
              const Expanded(child: Center(child: CustomLoadingIndicator()))
          ],
        );
      }),
    );
  }
}
