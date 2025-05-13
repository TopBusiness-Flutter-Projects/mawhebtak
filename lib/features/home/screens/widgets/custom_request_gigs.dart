
import 'package:mawhebtak/features/home/data/models/home_model.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/exports.dart';

class CustomRequestGigsList extends StatelessWidget {
  const CustomRequestGigsList(
      {super.key,
      required this.isLeftPadding,
      required this.isRightPadding,
      this.requestGigs});
  final bool isLeftPadding;
  final bool isRightPadding;
  final Top? requestGigs;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          start: isLeftPadding ? 16.w : 10.w, end: isRightPadding ? 16.w : 0.0),
      child: Stack(
        alignment: Alignment.centerLeft, // Add alignment to the Stack
        children: [
          (requestGigs?.image == null)
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: SizedBox(
                    width: 137.w, // Match image width
                    height: 137.w, // Match image height
                    child: Image.asset(
                      ImageAssets.tasweerPhoto,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: SizedBox(
                    width: 137.w, // Match image width
                    height: 137.w, // Match image height
                    child: Image.network(
                      requestGigs?.image ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.gigsDetailsScreen);
            },
            child: SizedBox(
              width: 137.w,
              height: 137.w,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end, // Center vertically
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Center horizontally
                  children: [
                    Text(
                      requestGigs?.title ?? "",
                      style: getMediumStyle(
                        color: AppColors.white,
                        fontSize: 14.sp,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                    ),
                    5.h.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
