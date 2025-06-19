import 'package:mawhebtak/core/utils/filter.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/profile/cubit/profile_cubit.dart';
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
    context.read<ProfileCubit>().getFollowersData(
        page: '1', isGetMore: false,
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
      if (context.read<ProfileCubit>().followersModel?.links?.next != null) {
        Uri uri = Uri.parse(
            context.read<ProfileCubit>().followersModel?.links?.next ?? "");
        String? page = uri.queryParameters['page'];
        context.read<ProfileCubit>().getFollowersData(
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
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (BuildContext context, state) {
        var cubit = context.read<ProfileCubit>();
        return Scaffold(
          body: Column(
            children: <Widget>[
              CustomAppBarWithClearWidget(
                title: "followers".tr(),
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
                child: (cubit.followersModel?.data?.length == 0)?
                 Center(child: Text("no_data".tr()),):
                ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: cubit.followersModel?.data?.length ?? 0,
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
