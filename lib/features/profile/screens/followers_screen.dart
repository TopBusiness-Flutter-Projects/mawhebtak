import 'package:mawhebtak/core/utils/filter.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/home/cubits/top_talents_cubit/top_talents_cubit.dart';
import 'package:mawhebtak/features/profile/screens/widgets/followers_widget.dart';
import '../../../core/exports.dart';
import '../../events/screens/widgets/custom_apply_app_bar.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({super.key});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  late final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    context.read<TopTalentsCubit>().topTalentsData(page: '1', isGetMore: false);
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (context.read<TopTalentsCubit>().topTalents?.links?.next != null) {
        Uri uri = Uri.parse(
            context.read<TopTalentsCubit>().topTalents?.links?.next ?? "");
        String? page = uri.queryParameters['page'];
        context.read<TopTalentsCubit>().topTalentsData(
            page: page ?? '1',
            isGetMore: true,
            orderBy: selctedFilterOption?.key);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopTalentsCubit, TopTalentsState>(
      builder: (BuildContext context, state) {
        var cubit = context.read<TopTalentsCubit>();
        return Scaffold(
          body: Column(
            children: <Widget>[
              CustomAppBarWithClearWidget(
                title: "followers".tr(),
              ),
              SizedBox(
                height: 10.h,
              ),
              (state is TopTalentsStateLoading)
                  ? const Expanded(
                      child: Center(
                      child: CustomLoadingIndicator(),
                    ))
                  : Expanded(
                    child: ListView.builder(
                        controller: scrollController,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: cubit.topTalents?.data?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return FollowersWidget(
                            index: index,
                          );
                        },
                      ),
                  ),
              if(state is TopTalentsStateLoadingMore)
              const Center(child: CustomLoadingIndicator(),)
            ],
          ),
        );
      },
    );
  }
}
