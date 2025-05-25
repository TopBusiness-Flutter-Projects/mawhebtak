import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/exports.dart';
import '../../home/screens/widgets/custom_announcement_widget.dart';
import '../../home/screens/widgets/custom_request_gigs.dart';
import '../cubit/announcement_cubit.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AnnouncementCubit>();
    return BlocBuilder<AnnouncementCubit, AnnouncementState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              CustomSimpleAppbar(
                  title: "announcments".tr(), isSearchWidget: true),
              SizedBox(height: 4.h),
              SizedBox(
                height: 145.w, // Match image width
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomRequestGigsList(
                      isLeftPadding: index == 0 ? true : false,
                      isRightPadding: false,
                    );
                  },
                ),
              ),
              SizedBox(
                  height: 500.h,
                  width: double.infinity,
                  child: CustomAnnouncementWidget(isAnnouncements: true)),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.newAnnouncementScreen);
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            splashColor: Colors.transparent,
            highlightElevation: 0,
            child: SvgPicture.asset(
              AppIcons.addIcon,
              // width: 56, // نفس مقاس الفلوتينج الأصلي
              // height: 56,
            ),
          ),
        );
      },
    );
  }
}
