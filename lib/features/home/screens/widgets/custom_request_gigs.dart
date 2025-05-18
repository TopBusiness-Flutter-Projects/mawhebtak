
import 'package:mawhebtak/features/home/data/models/request_gigs_model.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/exports.dart';

class CustomRequestGigsList extends StatelessWidget {
  const CustomRequestGigsList({
    super.key,
    required this.isLeftPadding,
    required this.isRightPadding,
    this.requestGigs,
  });

  final bool isLeftPadding;
  final bool isRightPadding;
  final EventAndGigsModel? requestGigs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: isLeftPadding ? 16.w : 10.w,
        end: isRightPadding ? 16.w : 10.0.w,
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.gigsDetailsScreen);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            image: DecorationImage(
              image: requestGigs?.image != null &&
                  requestGigs!.image!.isNotEmpty
                  ? NetworkImage(requestGigs!.image!)
                  : const AssetImage(ImageAssets.tasweerPhoto) as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding:  EdgeInsets.all(8.0.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                width: 130.w,
                child: Padding(
                  padding:  EdgeInsets.only(bottom: 10.h,left: 10.w,right: 10.w),
                  child: Text(
                    requestGigs?.title ?? "",
                    style: getMediumStyle(
                      color: AppColors.white,
                      fontSize: 16.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
