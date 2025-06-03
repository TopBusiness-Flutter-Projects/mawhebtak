import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/casting/cubit/casting_cubit.dart';
import 'package:mawhebtak/features/casting/cubit/casting_state.dart';
import 'package:mawhebtak/features/casting/data/model/request_gigs_model.dart';
import '../../../../../core/exports.dart';
import '../../../../../core/preferences/preferences.dart';
import '../../../../../core/utils/check_login.dart';
import '../../../../home/screens/widgets/follow_button.dart';

class GigsRequest extends StatelessWidget {
  const GigsRequest({super.key, required this.gigsRequestList});
  final GigsRequestList? gigsRequestList;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                  width: 40.w,
                  child: Image.asset(ImageAssets.profileImage),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(gigsRequestList?.user?.name ?? "",
                              style: getMediumStyle(fontSize: 18.sp)),
                          AutoSizeText(
                            gigsRequestList?.user?.headline ?? "",
                            style: getRegularStyle(
                                fontSize: 16.sp, color: AppColors.grayLight),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          gigsRequestList?.status ?? "",
                          style: getRegularStyle(
                              fontSize: 18.sp, color: AppColors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<CastingCubit, CastingState>(builder: (context, state) {
            var cubit = context.read<CastingCubit>();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: (state is ActionGigStateLoading)
                  ? const Center(
                      child: CustomLoadingIndicator(),
                    )
                  : (gigsRequestList?.status == 'new')
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final user =
                                    await Preferences.instance.getUserModel();
                                if (user.data?.token == null) {
                                  checkLogin(context);
                                } else {
                                  cubit.actionGig(
                                      status: "accepted",
                                      gigId: cubit.getDetailsGigsModel?.data?.id
                                              .toString() ??
                                          '',
                                      requestId:
                                          gigsRequestList?.id.toString() ?? "");
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomContainerButton(
                                  title: 'accept'.tr(),
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final user =
                                    await Preferences.instance.getUserModel();
                                if (user.data?.token == null) {
                                  checkLogin(context);
                                } else {
                                  cubit.actionGig(
                                      status: "rejected",
                                      gigId: cubit.getDetailsGigsModel?.data?.id
                                              .toString() ??
                                          '',
                                      requestId:
                                          gigsRequestList?.id.toString() ?? "");
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomContainerButton(
                                  title: 'reject'.tr(),
                                  color: AppColors.transparent,
                                  borderColor: AppColors.red,
                                  textColor: AppColors.red,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
            );
          })
        ],
      ),
    );
  }
}
