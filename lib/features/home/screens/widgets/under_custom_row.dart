import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/features/home/data/models/home_model.dart';
import '../../../../core/exports.dart';
import 'follow_button.dart';

class UnderCustomRow extends StatelessWidget {
  const UnderCustomRow({super.key, this.userTalent});
 final TopTalent? userTalent;
  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
        width: getWidthSize(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding:  EdgeInsets.all(8.0.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap:(){
                      Navigator.pushNamed(context, Routes.profileScreen,arguments: userTalent?.id ??"");
                    },
                    child:
                    userTalent?.image == null ?
                    SizedBox(

                      child: Image.asset(ImageAssets.profileImage),
                    ):
                    CircleAvatar(
                      radius: 30.r,
                      backgroundImage: userTalent?.image != null && userTalent!.image!.isNotEmpty
                          ? NetworkImage(userTalent!.image!)
                          : null,
                      child: userTalent?.image == null || userTalent!.image!.isEmpty
                          ? const Icon(Icons.person)
                          : null,
                    )
                  ),
                  Text(userTalent?.name ?? "", style: getMediumStyle(color: AppColors.white,fontSize: 16.sp)),
                  Text(userTalent?.headline ?? "Talent / Actor Expert", style: getRegularStyle(color: AppColors.grayText,fontSize: 14.sp)),
               //   CustomButton(title: 'Follow', style: getMediumStyle(color: AppColors.white))
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding:  EdgeInsets.all(8.0.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 30.h,
                    width: 40.w,
                    child: Container(),
                  ),
                  Text("${userTalent?.followersCount ?? 20}  followers", style: getMediumStyle(color: AppColors.white,fontSize: 14.sp)),
                  SizedBox(height: 5.h,),
                  // Text("Ahmed Mokhtar", style: getMediumStyle(color: AppColors.white)),
                  CustomContainerButton(title: "follow".tr(),)
                ],
              ),
            ),
          ],
        ),
      )
    ;
  }
}
