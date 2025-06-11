import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_cubit.dart';
import '../../../config/routes/app_routes.dart';
import '../../events/screens/details_event_screen.dart';
import '../cubit/feeds_state.dart';
import 'widgets/post_details_widget.dart';

class PostDetailsScreen extends StatefulWidget {
  PostDetailsScreen({super.key, this.deepLinkDataModel});

  DeepLinkDataModel? deepLinkDataModel;
  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  @override
  void initState() {
    context
        .read<FeedsCubit>()
        .getDetailsById(postId: widget.deepLinkDataModel?.id.toString() ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedsCubit, FeedsState>(
      builder: (context, state) {
        var cubit = context.read<FeedsCubit>();
        return WillPopScope(
          onWillPop: () {
            if (widget.deepLinkDataModel?.isDeepLink == true) {
              Navigator.pushReplacementNamed(context, Routes.mainRoute);
            }
            return Future.value(false);
          },
          child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () {
                  if (widget.deepLinkDataModel?.isDeepLink == true) {
                    Navigator.pushReplacementNamed(context, Routes.mainRoute);
                  }
                },
              ),
            ),
            body: state is LoadingGetPostDetails
                ? const Center(
                    child: CustomLoadingIndicator(),
                  )
                : ListView(
                    children: [
                      PostDetailsWidget(
                        post: cubit.postDetails?.data,
                        feedsCubit: cubit,
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
