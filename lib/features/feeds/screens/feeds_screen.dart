
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_cubit.dart';
import 'package:mawhebtak/features/feeds/cubit/feeds_state.dart';

import '../../../core/exports.dart';
import '../../home/screens/widgets/custom_app_bar_row.dart';
import '../../profile/screens/widgets/time_line_widget/time_line_list.dart';
import '../../profile/screens/widgets/time_line_widget/what_do_you_want.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  late final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      if (context.read<FeedsCubit>().posts?.links?.next != null) {
        Uri uri = Uri.parse(
            context.read<FeedsCubit>().posts?.links?.next??"");
        String? page = uri.queryParameters['page'];
        context.
        read<FeedsCubit>().
        postsData(page: page ??'1' , isGetMore: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var feeds = context.read<FeedsCubit>().posts;
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocBuilder<FeedsCubit,FeedsState>(
          builder: (context,state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                 padding: EdgeInsets.only(top: 20.h),
                 child: CustomAppBarRow(
                    colorTextFromSearchTextField:
                        AppColors.darkGray.withOpacity(0.3),
                    backgroundColorTextFieldSearch: AppColors.grayLite,
                    isMore: true,
                    colorSearchIcon: AppColors.secondPrimary,
                    backgroundNotification: AppColors.primary,
                  ),
                ),
                Container(
                 color: AppColors.grayLite,
                  height: getHeightSize(context) / 50,
                ),
                //what do you want
                const WhatDoYouWant(),
               10.h.verticalSpace,
               switch(state){
                
                 FeedsStateLoading() => const Expanded(child: Center(child: CustomLoadingIndicator(),),),
                 FeedsStateLoaded() || FeedsStateLoadingMore()=>  
                     ListView.separated(
                   controller: scrollController,
                   shrinkWrap: true,
                   physics: const NeverScrollableScrollPhysics(),
                   itemCount: feeds?.data?.length ?? 0,
                   itemBuilder: (BuildContext context, int index) {
                     return  TimeLineList(
                       feeds: feeds!.data![index],
                     );
                   },
                   separatorBuilder: (BuildContext context, int index) {
                     return SizedBox(
                       height: 15.h,
                     );
                   },
                 ),
                 FeedsStateError() => Expanded(child: Center(child: Text(state.errorMessage),),),
               }
              ],
            );
          }
        ),
      ),
    );
  }
}
