import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawhebtak/features/profile/data/models/profile_model.dart';
import '../../../../../core/exports.dart';
import '../../add_new_experience.dart';

class ExperinceWidget extends StatefulWidget {
  const ExperinceWidget({super.key, this.experience, this.isMe});

  final Experience? experience;
  final bool? isMe;

  @override
  State<ExperinceWidget> createState() => _ExperinceWidgetState();
}

class _ExperinceWidgetState extends State<ExperinceWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.only(left: 16.0.w, right: 16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(ImageAssets.experience),
              SizedBox(width: 5.w),
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.experience?.title ?? "",
                      style: getMediumStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                        "${'from'.tr()}: ${DateFormat('yyyy-MM-dd').format(widget.experience?.from ?? DateTime.now())}- ${'to'.tr()}: ${widget.experience?.to == null ? 'present'.tr() : DateFormat('yyyy-MM-dd').format(widget.experience?.to ?? DateTime.now())}",
                        style: getRegularStyle(
                            fontHeight: 1,
                            fontSize: 11.sp,
                            color: AppColors.gray)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.experience?.description ?? "",
                          maxLines: _expanded ? null : 3,
                          overflow: TextOverflow.fade,
                          style: getRegularStyle(
                              color: AppColors.grayText3, fontSize: 14.sp),
                        ),
                        if ((widget.experience?.description!.length ?? 0) > 100)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _expanded = !_expanded;
                              });
                            },
                            child: Text(
                              _expanded ? 'see_less'.tr() : 'see_all'.tr(),
                              style: TextStyle(
                                  fontSize: 14.sp, color: AppColors.primary),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              if (widget.isMe == true)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddNewExperienceScreen(
                                editing: widget.experience)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(AppIcons.bioIcon),
                  ),
                )
            ],
          ),
        ),
        SizedBox(height: 4.h),
        Container(
          height: 2.h,
          color: AppColors.grayLite,
          width: double.infinity,
        ),
      ],
    );
  }
}
