import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/widgets/custom_simple_appbar.dart';

import '../../../core/exports.dart';
import '../../home/screens/widgets/custom_announcement_widget.dart';
import '../../home/screens/widgets/custom_request_gigs.dart';
import '../cubit/announcement_cubit.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit=context.read<AnnouncementCubit>();
    return BlocBuilder<AnnouncementCubit, AnnouncementState>(builder: (BuildContext context, state) { return  Scaffold(body:
    Column(children: [
      SizedBox(height: 20.h,),
      CustomSimpleAppbar(title: "announcments".tr(),isSearchWidget: true),
      SizedBox(height: 4.h),
      SizedBox(
        height: 145.w, // Match image width
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount:cubit.items.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return CustomRequestGigstList(isLeftPadding:index==0?true:false, isRightPadding: index==cubit.items.length-1?true:false,);
          },),
      ),
      CustomAnnouncementWidget(isAnnouncements: true,)
    ],),
    ); },);
  }
}
