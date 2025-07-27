import 'package:mawhebtak/core/exports.dart';

class FutureApp extends StatelessWidget {
  const FutureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomSimpleAppbar(title: "future_app".tr()),
          SizedBox(height: 10.h),
          Expanded(
            child: GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 3 / 4,
              ),
              children: [
                futureAppWidget(
                    nameApp: "At3aby", image: "assets/images/at3aby_logo.jpg"),
                futureAppWidget(
                    nameApp: "Travel Club", image: "assets/images/travel_club.png"),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Container futureAppWidget({
    required String nameApp,
    required String image,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurStyle: BlurStyle.outer,
              color: AppColors.gray,
              blurRadius: 1.2,
              offset: const Offset(0, 4)
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(8.sp),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(image),
          ),
          SizedBox(height: 8.h),
          Text(nameApp,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp)),
        ],
      ),
    );
  }
}
