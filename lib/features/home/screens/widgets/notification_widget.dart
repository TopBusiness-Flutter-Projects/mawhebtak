import 'package:mawhebtak/config/routes/app_routes.dart';
import 'package:mawhebtak/features/events/screens/details_event_screen.dart';
import 'package:mawhebtak/features/home/data/models/notifications_model.dart';
import '../../../../core/exports.dart';
import '../../../../core/widgets/custom_container_with_shadow.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key, this.notification});
  final GetNotificationsModelData? notification;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // done
        if (notification?.referenceTable.toString() == "gigs") {
          Navigator.pushNamed(context, Routes.gigsDetailsScreen,
              arguments: DeepLinkDataModel(
                  id: notification?.referenceId.toString() ?? '',
                  isDeepLink: false));
        } else if (notification?.referenceTable.toString() == "user_jobs") {
          Navigator.pushNamed(context, Routes.jobDetailsRoute, arguments: {
            "isDeepLink": false,
            'userJopId': notification?.referenceId.toString()
          });
        } else if (notification?.referenceTable.toString() == "profile") {
          Navigator.pushNamed(context, Routes.profileRoute,
              arguments: DeepLinkDataModel(
                  id: notification?.referenceId.toString() ?? "",
                  isDeepLink: false));
        }
        // done
        else if (notification?.referenceTable.toString() == "announces") {
          Navigator.pushNamed(context, Routes.detailsAnnouncementScreen,
              arguments: {
                'announcementId': notification?.referenceId.toString(),
                "isDeeplink": false
              });
        }
        // done
        else if (notification?.referenceTable.toString() == "posts") {
          Navigator.pushNamed(context, Routes.postDetailsRoute,
              arguments: DeepLinkDataModel(
                  id: notification?.referenceId.toString() ?? "",
                  isDeepLink: false));
        } else if (notification?.referenceTable.toString() == "events") {
          Navigator.pushNamed(context, Routes.eventsDetailsRoute,
              arguments: DeepLinkDataModel(
                  id: notification?.referenceId.toString() ?? "",
                  isDeepLink: false));
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        child: CustomContainerWithShadow(
          color: notification?.seen == 0 ? AppColors.secondPrimary.withOpacity(0.3) : AppColors.white,
            child: Padding(
          padding: EdgeInsets.all(10.0.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  width: 35.w,
                  height: 35.w,
                  child: Image.asset(ImageAssets.notificationImage)),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    notification?.body ?? "",
                    style: getMediumStyle(fontSize: 14.sp),
                  ),
                  Text(
                    notification?.createdAt.toString().substring(0, 10) ?? "",
                    style: getMediumStyle(
                        fontSize: 13.sp, color: AppColors.grayDate),
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
