import 'package:flutter_svg/svg.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/announcement/cubit/announcement_cubit.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/exports.dart';
import '../../../core/utils/filter.dart';
import '../../home/screens/widgets/custom_announcement_widget.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  @override
  late final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    context.read<AnnouncementCubit>().announcementsData(page: '1', isGetMore: false,orderBy: "desc");
    context.read<AnnouncementCubit>().getCategoryFromAnnouncment(page: '1', isGetMore: false, orderBy: "desc");
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
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          CustomSimpleAppbar(
              filterType: 'announcements',
              title: "announcments".tr(),
              isSearchWidget: true),
          SizedBox(height: 4.h),
          Flexible(
            child: BlocBuilder<AnnouncementCubit, AnnouncementState>(
                builder: (context, state) {
              var cubit = context.read<AnnouncementCubit>();
              var announcementsData = cubit.announcements;
              var announcementsCategoryData = cubit.announcementCategoryModel;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 145.w,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: announcementsCategoryData?.data?.length ?? 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: 10.w, end: 10.w),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context,
                                  Routes.detailsOfMainCategoryAnnouncementRoute,
                                  arguments: announcementsCategoryData
                                      ?.data?[index].id
                                      .toString());
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
                                          bottom: 10.h,
                                          left: 10.w,
                                          right: 10.w),
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      AppColors.secondPrimary,
                                                ),
                                                child: Text(
                                                  (announcementsCategoryData
                                                              ?.data![index]
                                                              .name ??
                                                          "")
                                                      .substring(
                                                          0,
                                                          (announcementsCategoryData
                                                                          ?.data![
                                                                              index]
                                                                          .name
                                                                          ?.length ??
                                                                      0) >=
                                                                  5
                                                              ? 5
                                                              : (announcementsCategoryData
                                                                      ?.data![
                                                                          index]
                                                                      .name
                                                                      ?.length ??
                                                                  0)),
                                                  style: getMediumStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TextSpan(
                                              text: (announcementsCategoryData
                                                              ?.data![index]
                                                              .name
                                                              ?.length ??
                                                          0) >
                                                      5
                                                  ? (announcementsCategoryData
                                                              ?.data![index]
                                                              .name ??
                                                          "")
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
                    ),
                  ),
                  (state is AnnouncementsStateLoading)
                      ? const Expanded(
                    child: Center(
                      child: CustomLoadingIndicator(),
                    ),
                  )
                      : (announcementsData?.data == [] || announcementsData?.data?.length == 0)
                      ? Expanded(
                      child: Center(
                          child: Text(
                            "no_data".tr(),
                            style: TextStyle(color: AppColors.black),
                          )))
                      : Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w, right: 8.w),
                        child: RefreshIndicator(
                          onRefresh:()async{
                            context.read<AnnouncementCubit>().announcementsData(page: '1');
                          },
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            controller: scrollController,
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                SizedBox(
                                  height: getSize(context)/1,
                                  child: CustomAnnouncementWidget(
                                    index: index,
                                    isMainWidget: true,
                                    announcement: announcementsData?.data?[index],

                                  ),
                                ),
                            itemCount: announcementsData?.data?.length ?? 0,
                          ),
                        ),
                      )),
                  if (state is AnnouncementsStateLoadingMore)
                    const Center(child: CustomLoadingIndicator()),

                ],
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.newAnnouncementScreen);
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        splashColor: Colors.transparent,
        highlightElevation: 0,
        child: SvgPicture.asset(
          AppIcons.addIcon,
          // width: 56, // نفس مقاس الفلوتينج الأصلي
          // height: 56,
        ),
      ),
    );
  }
}
