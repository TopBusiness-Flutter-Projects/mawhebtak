import 'package:mawhebtak/features/profile/data/models/profile_model.dart';
import '../../../../../core/exports.dart';
import '../../../../events/screens/widgets/custom_row_event.dart';
import 'custom_row_section.dart';
import 'experince_widget.dart';

class AboutWidget extends StatelessWidget {
  AboutWidget({super.key, this.profileModel});
  ProfileModel? profileModel;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
              ),
              CustomRowSection(
                title: "bio".tr(),
              ),
              SizedBox(
                height: 4.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.0.w, right: 16.w),
                child: Text(

                  profileModel?.data?.bio ?? "",
                  style: getRegularStyle(
                      fontSize: 13.sp, color: AppColors.grayMedium),
                ),
              ),
            ],
          ),
          Container(
              height: 8.h, color: AppColors.grayLite, width: double.infinity),
          SizedBox(
            height: 10.h,
          ),
          CustomRowSection(title: "personal_info".tr()),
          CustomRowEvent(
              text: 'email'.tr(), text2: profileModel?.data?.email ?? ""),
          CustomRowEvent(
              text: 'phone'.tr(),
              text2: profileModel?.data?.phone ?? "",
              isSecond: true),
          CustomRowEvent(
              text: 'age'.tr(), text2: profileModel?.data?.age.toString() ?? ""),
          CustomRowEvent(
              text: 'location'.tr(),
              text2: profileModel?.data?.location ?? "",
              isSecond: true),
          CustomRowEvent(
              text: 'syndicate'.tr(),
              text2: profileModel?.data?.syndicate.toString() ?? ""),
          Container(
              height: 8.h, color: AppColors.grayLite, width: double.infinity),
          SizedBox(
            height: 10.h,
          ),
          CustomRowSection(title: "experience".tr()),
          (profileModel?.data?.experiences == [])?
          Center(child: Text("no_data".tr()),):
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: profileModel?.data?.experiences?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return ExperinceWidget(
                  experience: profileModel?.data?.experiences?[index],
                );

              },
            ),
          )
        ],
      ),
    );
  }
}
