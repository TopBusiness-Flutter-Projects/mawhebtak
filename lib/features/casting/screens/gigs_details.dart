import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/casting/cubit/casting_cubit.dart';
import 'package:mawhebtak/features/casting/cubit/casting_state.dart';
import 'package:mawhebtak/features/profile/screens/widgets/my_gigs/requst_gigs_request.dart';
import '../../../core/exports.dart';
import '../../casting/screens/widgets/gigs_widgets.dart';

class GigsDetailsScreen extends StatefulWidget {
  const GigsDetailsScreen({super.key, required this.id});
  final String id;

  @override
  State<GigsDetailsScreen> createState() => _GigsDetailsScreenState();
}

class _GigsDetailsScreenState extends State<GigsDetailsScreen> {
  @override
  void initState() {
    context.read<CastingCubit>().getDetailsGigs(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomSimpleAppbar(title: "gig_details".tr()),
            10.h.verticalSpace,
            BlocBuilder<CastingCubit, CastingState>(builder: (context, state) {
              var cubit = context.read<CastingCubit>();
              return (state is DetailsGigsStateLoading)
                  ? const Center(child: CustomLoadingIndicator())
                  : Column(
                      children: [
                        Container(
                          color:AppColors.white,
                          child: GigsWidget(
                            isDetails: false,
                            eventAndGigsModel: cubit.getDetailsGigsModel?.data,
                            isWithButton: false,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        if(cubit.getDetailsGigsModel?.data?.gigsRequests?.length != 0)
                          Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20.0.w),
                              child: Text(
                                "gig_requests".tr(),
                                style: getMediumStyle(
                                    fontSize: 20.sp, color: AppColors.darkGray),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            //list of requests
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cubit.getDetailsGigsModel?.data?.gigsRequests?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                return  GigsRequest(

                                  gigsRequestList:cubit.getDetailsGigsModel?.data?.gigsRequests?[index] ,
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 10.h,
                                );
                              },
                            )
                          ],
                        ),
                      ],
                    );
            })
          ],
        ),
      ),
    );
  }
}
