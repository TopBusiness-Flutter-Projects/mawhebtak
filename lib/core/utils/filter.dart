import 'package:mawhebtak/features/announcement/cubit/announcement_cubit.dart';
import 'package:mawhebtak/features/casting/cubit/casting_cubit.dart';
import '../../features/home/cubits/top_events_cubit/top_events_cubit.dart';
import '../../features/home/cubits/top_talents_cubit/top_talents_cubit.dart';
import '../../features/jobs/cubit/jobs_cubit.dart';
import '../exports.dart';

class SortOption {
  String? name;
  String? categoryId;
  String key;

  SortOption({
    this.name,
    this.categoryId,
    required this.key,
  });
}

SortOption? selctedFilterOption;

void showSortOptions(BuildContext context, String filterType,
    {String? categoryId}) async {
  List<SortOption> options = [
    SortOption(name: 'asc'.tr(), key: 'asc'),
    SortOption(name: 'desc'.tr(), key: 'desc'),
  ];

  final selectedOption = await showModalBottomSheet<SortOption>(
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((option) {
            return ListTile(
              title: Text(option.name ?? ''),
              onTap: () => Navigator.pop(context, option),
            );
          }).toList(),
        ),
      );
    },
  );

  if (selectedOption != null) {
    selctedFilterOption = selectedOption;

    print('Selected Name: ${selectedOption.name}');
    print('Selected Key: ${selectedOption.key}');
    print('Selected filterType:$filterType');
    print('Selected filterType:${filterType == 'get_category_gigs'}');

    if (filterType == 'event') {
      context.read<TopEventsCubit>().topEventsData(
          orderBy: selctedFilterOption?.key ?? 'desc',
          page: '1',
          isGetMore: false);
    } else if (filterType == 'announcements') {
      context.read<AnnouncementCubit>().announcementsData(
          page: '1',
          isGetMore: false,
          orderBy: selctedFilterOption?.key ?? 'desc');
    } else if (filterType == 'gigs') {
      context.read<CastingCubit>().allGigsData(
          page: '1',
          isGetMore: false,
          orderBy: selctedFilterOption?.key ?? 'desc');
    } else if (filterType == 'get_category_gigs') {
      context.read<CastingCubit>().getCategoryFromGigs(
          page: '1',
          isGetMore: false,
          orderBy: selctedFilterOption?.key ?? 'desc');
    } else if (filterType == 'top_talents') {
      context.read<TopTalentsCubit>().topTalentsData(
          page: '1',
          isGetMore: false,
          orderBy: selctedFilterOption?.key ?? 'desc');
    } else if (filterType == 'job') {
      context.read<JobsCubit>().getUserJobData(
          page: '1',
          isGetMore: false,
          orderBy: selctedFilterOption?.key ?? 'desc');
    } else {}
  } else {}
}
