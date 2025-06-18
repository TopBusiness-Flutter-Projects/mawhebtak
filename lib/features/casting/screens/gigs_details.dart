import 'package:mawhebtak/core/widgets/custom_button.dart';
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
    return BlocBuilder<CastingCubit, CastingState>(
      builder: (context, state) {
        var castingCubit = context.read<CastingCubit>();

        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: (state is DetailsGigsStateLoading)
              ? const Center(child: CustomLoadingIndicator())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      10.h.verticalSpace,
                      CustomSimpleAppbar(title: "gig_details".tr()),
                      10.h.verticalSpace,
                      Column(
                        children: [
                          Container(
                            color: AppColors.white,
                            child: GigsWidget(
                              isFromDetails: true,
                              index: 1,
                              castingCubit: castingCubit,
                              eventAndGigsModel:
                                  castingCubit.getDetailsGigsModel?.data,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          if (castingCubit.getDetailsGigsModel?.data
                                  ?.gigsRequests?.length !=
                              0)
                            if (castingCubit
                                    .getDetailsGigsModel?.data?.isMine ==
                                true)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 20.0.w),
                                    child: Text(
                                      "gig_requests".tr(),
                                      style: getMediumStyle(
                                          fontSize: 20.sp,
                                          color: AppColors.darkGray),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  //list of requests

                                  ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: castingCubit.getDetailsGigsModel
                                            ?.data?.gigsRequests?.length ??
                                        0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GigsRequest(
                                        gigsRequestList: castingCubit
                                            .getDetailsGigsModel
                                            ?.data
                                            ?.gigsRequests?[index],
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
                      ),
                      10.h.verticalSpace,
                      if (castingCubit.getDetailsGigsModel?.data?.isMine ==
                          true)
                        CustomButton(
                            title: 'delete'.tr(),
                            color: AppColors.red,
                            onTap: () {
                              castingCubit.deleteGigs(

                                  gigId:widget.id,context:  context);
                            })
                    ],
                  ),
                ),
        );
      },
    );
  }
}
