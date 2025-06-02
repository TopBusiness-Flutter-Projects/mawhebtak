import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/home/cubits/top_talents_cubit/top_talents_cubit.dart';
import 'package:mawhebtak/features/home/screens/widgets/custom_top_talents_list.dart';

class TopTalentsScreen extends StatefulWidget {
  const TopTalentsScreen({super.key});

  @override
  State<TopTalentsScreen> createState() => _TopTalentsScreenState();
}

class _TopTalentsScreenState extends State<TopTalentsScreen> {
  late final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    context.read<TopTalentsCubit>().topTalentsData(
        page: '1', isGetMore: false);
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (context.read<TopTalentsCubit>().topTalents?.links?.next != null) {
        Uri uri = Uri.parse(
            context.read<TopTalentsCubit>().topTalents?.links?.next ?? "");
        String? page = uri.queryParameters['page'];
        context
            .read<TopTalentsCubit>()
            .topTalentsData(page: page ?? '1', isGetMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TopTalentsCubit, TopTalentsState>(
        builder: (context, state) {
          var topTalentData = context.read<TopTalentsCubit>().topTalents;
          return Column(
            children: [
              CustomSimpleAppbar(
                title: 'top_talents'.tr(),
                isActionButton: true,
                filterType: 'top_talents',
              ),
               (state is TopTalentsStateLoading)?
                const Expanded(
                  child: Center(
                    child: CustomLoadingIndicator(),
                  ),
                ):
                Expanded(
                  child: GridView.builder(
                      controller: scrollController,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                      ),
                      itemBuilder: (context, index) => CustomTopTalentsList(
                            topTalentsCubit:context.read<TopTalentsCubit>(),
                            index: index,
                            topTalentsData: topTalentData?.data?[index],
                          ),
                      itemCount: topTalentData?.data?.length ?? 0),
                ),
              if (state is TopTalentsStateLoadingMore)
                const CustomLoadingIndicator(),
            ],
          );
        },
      ),
    );
  }
}
