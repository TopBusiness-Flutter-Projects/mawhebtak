import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/features/home/screens/widgets/follow_button.dart';
import '../../../core/exports.dart';
import '../../home/screens/widgets/custom_announcement_widget.dart';
import '../cubit/announcement_cubit.dart';

class DetailsAnnouncementScreen extends StatelessWidget {
  const DetailsAnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit=context.read<AnnouncementCubit>();
    return BlocBuilder<AnnouncementCubit, AnnouncementState>(builder: (BuildContext context, state) { return  Scaffold(body:
    SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        SizedBox(height: 20.h,),
        CustomSimpleAppbar(title: "details".tr()),
        SizedBox(height: getHeightSize(context)/22),
      
        CustomAnnouncementWidget(isAnnouncements: true,),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Description",style: getSemiBoldStyle(fontSize: 14.sp,color: AppColors.darkGray),),
      ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(

              style: getRegularStyle(fontSize: 13.sp,color: AppColors.gray666),
                "Hi show my latest scenes with an amazing team Let’s start our work. Hi show my latest scenes with an amazing team Let’s start our work. Hi show my latest scenes with an amazing team Let’s start our work. Hi show my latest scenes with an amazing team Let’s start our work."),
          ),
          SizedBox(height: getHeightSize(context)/36,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomContainerButton(
              color: AppColors.primary,
              title: "Request this product",height: 40.h,),
          )
      
      ],),
    ),


    ); },);
  }
}
