
import 'package:auto_size_text/auto_size_text.dart';
import 'package:mawhebtak/features/events/screens/widgets/statics_cards.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/exports.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../../core/utils/check_login.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../cubit/event_cubit.dart';
import '../../data/model/event_details_model.dart';
import '../details_event_screen.dart';
import 'custom_apply_button.dart';
import 'custom_row_event.dart';

class EventDetailsBody extends StatelessWidget {
  const EventDetailsBody({
    super.key,
    this.item,
    this.mainDeepLink,
  });
  final GetMainEvenDetailsModelData? item;
  final DeepLinkDataModel? mainDeepLink;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        10.h.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 16.h),
          child: Text(
            'created_by'.tr(),
            style: getMediumStyle(fontSize: 14.sp, color: AppColors.darkGray),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.profileRoute,
                    arguments: DeepLinkDataModel(
                        id: item?.eventOwner?.id.toString() ?? '',
                        isDeepLink: false),
                  );
                },
                child: SizedBox(
                  height: 40.h,
                  width: 40.w,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      item?.eventOwner?.image ?? '',
                    ),
                    backgroundColor: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(item?.eventOwner?.name ?? '',
                        style: getMediumStyle(fontSize: 16.sp)),
                    if (item?.eventOwner?.headline != null)
                      AutoSizeText(
                        item?.eventOwner?.headline.toString() ?? "",
                        style: getRegularStyle(
                            fontSize: 14.sp, color: AppColors.grayLight),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        10.h.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 16.h),
          child: Text(
            'events_details'.tr(),
            style: getMediumStyle(fontSize: 14.sp, color: AppColors.darkGray),
          ),
        ),
        10.h.verticalSpace,

        CustomRowEvent(
          text: 'location',
          text2: item?.location ?? '',
        ),
        CustomRowEvent(
          text: 'type',
          text2: item?.category ?? '',
          isSecond: true,
        ),
        CustomRowEvent(
          text: 'privacy',
          text2: item?.isPublic == 1 ? 'public'.tr() : 'private'.tr(),
        ),
        CustomRowEvent(
          text: 'event_date',
          text2: "${item?.from ?? ''} : ${item?.to ?? ''}",
          isSecond: true,
        ),
        const CustomRowEvent(
          text: 'description',
          text2: '',
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.h),
          child: Text(
            item?.description ?? '',
            style: getRegularStyle(fontSize: 13.sp, color: AppColors.darkGray),
          ),
        ),

        ((item?.enrolled == null && item?.revenu == null) ||
                (item?.enrolled == 0 && item?.revenu == 0))
            ? Container()
            : Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.h),
                child: Text(
                  'statistics'.tr(),
                  style: getMediumStyle(
                      fontSize: 14.sp, color: AppColors.darkGray),
                ),
              ),
        StaticsCards(item: item),
        SizedBox(height: 10.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 16.h),
          child: Text(
            'event_price'.tr(),
            style: getMediumStyle(fontSize: 14.sp, color: AppColors.darkGray),
          ),
        ),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            CustomRowEvent(
              text: "event_price".tr(),
              text2:item?.eventPrice.toString()??'',
              isSecond: true,
              isRequiredTalent: true,
            ),CustomRowEvent(
              text: "price_after_discount".tr(),
              text2:item?.priceAfterDiscount.toString()??'',
              isSecond: true,
              isRequiredTalent: true,
            ),CustomRowEvent(
              text: "vat".tr(),
              text2:item?.vat.toString()??'',
              isSecond: true,
              isRequiredTalent: true,
            ),
            CustomRowEvent(
              text: "final_price".tr(),
              text2:item?.finalPrice.toString()??'',
              isSecond: true,
              isRequiredTalent: true,
            ),
    ],

        ),
        if (item?.requirements?.length != 0)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 16.h),
            child: Text(
              'required_talents'.tr(),
              style: getMediumStyle(fontSize: 14.sp, color: AppColors.darkGray),
            ),
          ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: item?.requirements?.length ?? 0,
          itemBuilder: (context, index) {
            var itemRequired = item?.requirements?[index];
            return CustomRowEvent(
              text: itemRequired?.subCategory ?? '',
              text2:
                  '${itemRequired?.price ?? ''} ${itemRequired?.countryCurrency ?? ''}',
              isSecond: true,
              isRequiredTalent: true,
            );
          },
        ),
        20.h.verticalSpace,
        if (item?.isMine == false && item?.requirements?.length != 0)
          const CustomApplyButton(),
        if (item?.isMine == true)
          Padding(
              padding: const EdgeInsets.all(8),
              child: CustomButton(
                title: 'delete'.tr(),
                color: AppColors.red,
                onTap: () async {
                  final user = await Preferences.instance.getUserModel();
                  if (user.data?.token == null) {
                    checkLogin(context);
                  } else {
                    mainAppAwsomeDialog(
                      context,
                      onPressed: () {
                        context.read<EventCubit>().deleteEvent(
                            item?.id.toString() ?? '',
                            context,
                            mainDeepLink?.isDeepLink ?? false);
                      },
                      title: 'delete_event'.tr(),
                    );
                  }
                },
              )),
        10.h.verticalSpace
      ],
    );
  }
}
