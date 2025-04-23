import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mawhebtak/core/widgets/custom_text_form_field.dart';
import 'package:mawhebtak/features/announcement/cubit/announcement_cubit.dart';
import '../../../core/exports.dart';
import '../../../core/widgets/date_widget.dart';
import '../../../core/widgets/picker_drop_down.dart';
import '../../events/screens/widgets/custom_apply_app_bar.dart';
import '../../home/screens/widgets/follow_button.dart';

class NewAnnouncementScreen extends StatefulWidget {
  const NewAnnouncementScreen({super.key});

  @override
  State<NewAnnouncementScreen> createState() => _NewAnnouncementScreenState();
}

class _NewAnnouncementScreenState extends State<NewAnnouncementScreen> {
  DateTime? selectedDate;

  Future<void> selectDate() async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
     var cubit=context.read<AnnouncementCubit>();
    return BlocBuilder<AnnouncementCubit,AnnouncementState>(builder: (BuildContext context, state) {
      return  Scaffold(
        body:
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomAppBarWithClearWidget(title:  "new_announcments".tr(),),
            SizedBox(height: 10.h,),
            Padding(

              padding:  EdgeInsets.only(left: 16.0.w),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("announcment_title".tr(),style: getRegularStyle(fontSize: 14.sp),),
                  CustomTextField(
                    hintText: "John doe".tr(),hintTextSize: 18.sp,),
                  Text("select_category".tr(),style: getRegularStyle(fontSize: 14.sp),),
                  // CustomTextField(hintText: "1000".tr(),
                  //     hintTextSize: 18.sp,
                  //     suffixIcon: Icon(Icons.keyboard_arrow_down_sharp)
                  // ),
                  PriceDropdownTextField(prices: ["Photography","Dancer","Singer"], hintText: 'Photography',),

                  Text("price_range".tr(),style: getRegularStyle(fontSize: 14.sp),),
                  // CustomTextField(hintText: "1000".tr(),
                  //     hintTextSize: 18.sp,
                  //     suffixIcon: Icon(Icons.keyboard_arrow_down_sharp)
                  // ),

                  PriceDropdownTextField(prices: ["100","200","300"], hintText: '1000',),
               //   DatePickerField(title: 'expire_in'.tr(),),
        // DatePickerField(
        //   title: 'expire_in'.tr(),
        //   selectedDate: selectedDate,
        //   onTab: selectDate,
        // ),
                  CustomTextField(
                    controller: cubit.eventDateController,
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(10.0.r),
                      child: SvgPicture.asset(AppIcons.dateIcon),
                    ),
                    onTap: () {
                      cubit.selectDateTime(context);
                    },
                    hintTextSize: 14.sp,
                    hintText: "",
                  ),

10.verticalSpace,
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

                  10.verticalSpace,

                  Text("image_or_video".tr(),style: getRegularStyle(fontSize: 14.sp),),
                  5.verticalSpace,
                  InkWell(
                      onTap: (){
                        // cubit.pickMedia(context);
                      },
                      child: Image.asset(ImageAssets.imageOrVideo,height: 88.h,)),
                   SizedBox(height: getHeightSize(context)/33,),
                   Padding(
                     padding:  EdgeInsets.only(right: 16.0.w),
                     child: CustomContainerButton(
                       height: 48.h,
                       title: 'create_announcments'.tr(),color: AppColors.primary,),
                   ),
                  SizedBox(height: getHeightSize(context)/33,),

                ],),
            )

          ],),
      ),


      );
    },);
  }
}
