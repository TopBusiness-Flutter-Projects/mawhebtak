import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/casting/cubit/casting_cubit.dart';
import 'package:mawhebtak/features/casting/cubit/casting_state.dart';
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
    context
        .read<CastingCubit>()
        .getCategoryFromGigs(page: '1', isGetMore: false);
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (context.read<CastingCubit>().categoryModel?.links?.next != null) {
        Uri uri = Uri.parse(
            context.read<CastingCubit>().categoryModel?.links?.next ?? "");
        String? page = uri.queryParameters['page'];
        context
            .read<CastingCubit>()
            .getCategoryFromGigs(page: page ?? '1', isGetMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CastingCubit, CastingState>(builder: (context, state) {
        var cubit = context.read<CastingCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSimpleAppbar(
              title: 'request_gigs'.tr(),
              isActionButton: true,
              filterType: 'casting',
            ),
            (state is CategoryFromGigsStateLoading)
                ? const Expanded(
                    child: Center(
                      child: CustomLoadingIndicator(),
                    ),
                  )
                : Expanded(
                    child: GridView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisSpacing: 10),
                    itemCount: cubit.categoryModel?.data?.length,
                    itemBuilder: (context, index) {
                      var gigs = cubit.categoryModel?.data?[index];
                      return Padding(
                        padding:
                            EdgeInsetsDirectional.only(start: 10.w, end: 10.w),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context,
                                Routes.detailsOfMainCategoryFromGigsRoute,
                                arguments: gigs?.id.toString());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              image: const DecorationImage(
                                image: AssetImage(ImageAssets.tasweerPhoto),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(8.r),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.6),
                                    Colors.transparent
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: SizedBox(
                                  width: 130.w,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 10.h, left: 10.w, right: 10.w),
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.secondPrimary,
                                              ),
                                              child: Text(
                                                (gigs?.name ?? "").substring(
                                                    0,
                                                    (gigs?.name?.length ?? 0) >=
                                                            5
                                                        ? 5
                                                        : (gigs?.name?.length ??
                                                            0)),
                                                style: getMediumStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                          TextSpan(
                                            text: (gigs?.name?.length ?? 0) > 5
                                                ? (gigs?.name ?? "")
                                                    .substring(5)
                                                : "",
                                            style: getMediumStyle(
                                              color: AppColors.white,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )),
            if (state is CategoryFromGigsStateLoadingMore)
              const CustomLoadingIndicator(),
          ],
        );
      }),
    );
  }
}
