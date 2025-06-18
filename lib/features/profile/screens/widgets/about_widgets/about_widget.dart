import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawhebtak/core/widgets/custom_button.dart';
import 'package:mawhebtak/features/profile/data/models/profile_model.dart';

import '../../../../../core/exports.dart';
import '../../../../auth/login/data/models/login_model.dart';
import '../../../../events/screens/widgets/custom_row_event.dart';
import '../../../cubit/profile_cubit.dart';
import '../../add_new_experience.dart';
import 'custom_row_section.dart';
import 'experince_widget.dart';

class AboutWidget extends StatefulWidget {
  const AboutWidget({super.key, this.profileModel});

  final ProfileModel? profileModel;

  @override
  State<AboutWidget> createState() => _AboutWidgetState();
}

class _AboutWidgetState extends State<AboutWidget> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView(
        shrinkWrap: true,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.h),
              CustomRowSection(title: "bio".tr()),
              SizedBox(height: 4.h),
              Padding(
                padding: EdgeInsets.only(left: 16.0.w, right: 16.w),
                child: Text(
                  widget.profileModel?.data?.bio ?? "",
                  style: getRegularStyle(
                      fontSize: 13.sp, color: AppColors.grayMedium),
                ),
              ),
            ],
          ),
          Container(
              height: 8.h, color: AppColors.grayLite, width: double.infinity),
          SizedBox(height: 10.h),
          CustomRowSection(title: "personal_info".tr()),
          CustomRowEvent(
              text: 'email'.tr(),
              text2: widget.profileModel?.data?.email ?? ""),
          CustomRowEvent(
            text: 'phone'.tr(),
            text2: widget.profileModel?.data?.phone ?? "",
            isSecond: true,
          ),
          CustomRowEvent(
            text: 'age'.tr(),
            text2: widget.profileModel?.data?.age?.toString() ?? "",
          ),
          CustomRowEvent(
            text: 'location'.tr(),
            text2: widget.profileModel?.data?.location ?? "",
            isSecond: true,
          ),
          CustomRowEvent(
            text: 'syndicate'.tr(),
            text2: widget.profileModel?.data?.syndicate?.toString() ?? '',
          ),
          Container(
              height: 8.h, color: AppColors.grayLite, width: double.infinity),
          SizedBox(height: 10.h),
          if ((widget.profileModel?.data?.experiences?.isNotEmpty ?? false))
            Row(
              children: [
                Flexible(child: CustomRowSection(title: "experience".tr())),
                if (context.read<ProfileCubit>().user?.data?.id.toString() ==
                    widget.profileModel?.data?.id.toString())
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AddNewExperienceScreen()));
                      },
                      icon: Icon(
                        Icons.add_box,
                        color: AppColors.primary,
                      ))
              ],
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.profileModel?.data?.experiences?.length ?? 0,
            itemBuilder: (context, index) {
              return ExperinceWidget(
                isMe: widget.profileModel?.data?.id.toString() ==
                    context.read<ProfileCubit>().user?.data?.id?.toString(),
                experience: widget.profileModel?.data?.experiences?[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
