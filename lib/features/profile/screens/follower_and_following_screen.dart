import 'package:mawhebtak/core/utils/filter.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/home/cubits/top_talents_cubit/top_talents_cubit.dart';
import 'package:mawhebtak/features/profile/cubit/profile_cubit.dart';
import 'package:mawhebtak/features/profile/screens/widgets/followers_widget.dart';
import '../../../core/exports.dart';
import '../../events/screens/widgets/custom_apply_app_bar.dart';

class FollowerAndFollowingScreen extends StatefulWidget {
  const FollowerAndFollowingScreen({super.key, required this.pageName});
  final String pageName;
  @override
  State<FollowerAndFollowingScreen> createState() => _FollowerAndFollowingScreenState();
}

class _FollowerAndFollowingScreenState extends State<FollowerAndFollowingScreen> {
  late final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    context.read<TopTalentsCubit>().getFollowersAndFollowingData(
      paginate: 'true',
        page: '1', isGetMore: false,
      pageName: widget.pageName,
      orderBy: selctedFilterOption?.key,
      followedId: context.read<ProfileCubit>().user?.data?.id.toString(),
    );
    scrollController.addListener(_scrollListener);
    context.read<ProfileCubit>().loadUserFromPreferences();
    context.read<ProfileCubit>().getUserFromPreferences();
    super.initState();
  }

  _scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (context.read<TopTalentsCubit>().followerAndFollowingModel?.links?.next != null) {
        Uri uri = Uri.parse(
            context.read<TopTalentsCubit>().followerAndFollowingModel?.links?.next ?? "");
        String? page = uri.queryParameters['page'];
        context.read<TopTalentsCubit>().getFollowersAndFollowingData(
            pageName: widget.pageName,
            page: page ?? '1',
            isGetMore: true,
            orderBy: selctedFilterOption?.key,
           followedId: context.read<ProfileCubit>().user?.data?.id.toString(),
        );
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
                title: (widget.pageName != 'followers') ? "following".tr():"followers".tr(),
              ),
              SizedBox(
                height: 10.h,
              ),
              (state is GetFollowersStateLoading)
                  ? const Expanded(
                      child: Center(
                      child: CustomLoadingIndicator(),
                    ))
                  :
              Expanded(
                child: (cubit.followerAndFollowingModel?.data?.length == 0)?
                 Center(child: Text("no_data".tr()),):
                ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: cubit.followerAndFollowingModel?.data?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return FollowersWidget(
                        index: index,
                      );
                    },
                  ),
              ),
              if(state is GetFollowersStateLoadingMore)
              const Center(child: CustomLoadingIndicator(),)
            ],
          ),
        );
      },
    );
  }
}
