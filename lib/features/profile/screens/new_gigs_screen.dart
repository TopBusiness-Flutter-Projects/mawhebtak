import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/widgets/custom_text_form_field.dart';
import 'package:mawhebtak/features/home/screens/widgets/follow_button.dart';

import '../../../core/exports.dart';
import '../../../core/widgets/picker_drop_down.dart';
import '../../events/screens/widgets/custom_apply_app_bar.dart';
import '../cubit/profile_cubit.dart';

class NewGigsScreen extends StatelessWidget {
  const NewGigsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit=context.read<ProfileCubit>();
    return BlocBuilder<ProfileCubit,ProfileState>(builder: (BuildContext context, state) {
      return  Scaffold(body:
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomAppBarWithClearWidget(title:  "new_gig".tr(),),
        SizedBox(height: 10.h,),
        Padding(

          padding:  EdgeInsets.only(left: 16.0.w),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("gig_title_you_will_offer".tr(),style: getRegularStyle(fontSize: 14.sp),),
              CustomTextField(

                hintText: "John doe".tr(),hintTextSize: 18.sp,),
              Text("price_range".tr(),style: getRegularStyle(fontSize: 14.sp),),
              // CustomTextField(hintText: "1000".tr(),
              //     hintTextSize: 18.sp,
              //     suffixIcon: Icon(Icons.keyboard_arrow_down_sharp)
              // ),
              PriceDropdownTextField(prices: ["100","200","300"],),
              Text("select_location".tr(),style: getRegularStyle(fontSize: 14.sp),),

              CustomTextField(hintText: "".tr(),
                hintTextSize: 18.sp,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    textAlign: TextAlign.end,
                    "open_map".tr(),style:
                  getUnderLine(fontSize: 14.sp,color: AppColors.primary),),
                ),
              ),
              Text("description".tr(),style: getRegularStyle(fontSize: 14.sp),),

              CustomTextField(hintText: "".tr(),
                hintTextSize: 18.sp,
                maxLines: 6,
                isMessage: true,
              ),
              Text("image_or_video".tr(),style: getRegularStyle(fontSize: 14.sp),),
              5.verticalSpace,
              InkWell(
                  onTap: (){
cubit.pickMedia(context);
                  },
                  child: Image.asset(ImageAssets.imageOrVideo,height: 88.h,))
            ],),
        )

      ],),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child:
        CustomContainerButton(
          height: 48.h,title: "create_gig".tr(),
          color: AppColors.primary,
          onTap: (){
          },
        ),
      ),
    );
      },);
  }
}
