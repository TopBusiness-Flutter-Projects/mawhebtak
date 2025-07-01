import 'package:mawhebtak/features/packages/data/model/package_model.dart';

import '../../../../../core/exports.dart';
import 'custom_container_package.dart';

class PackageItemWidget extends StatelessWidget {
  PackageItemWidget({
    super.key,
    this.item,
    this.onTap,
  });
  PackagesModelData? item;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: ContainerOfPackage(
        height: 72.h,
        widgetOne: Flexible(
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    item?.title ?? '',
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: AppStrings.fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                Text(
                  '${item?.numberOfAds.toString()} ${'ads_in_month'.tr()}',
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: AppStrings.fontFamily,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.textGreyColor,
                  ),
                ),
              ],
            )),
        widgetTwo: Row(
          children: [
            Text(
              '${item?.price?.toString()}',
              maxLines: 1,
              style: TextStyle(
                  fontFamily: AppStrings.fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                  color: AppColors.primary),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 8.0.w),
              child: IconButton(
                onPressed: () {
                  // Fluttertoast.showToast(
                  //   msg: 'ادفع الان',
                  //   backgroundColor: AppColors.black,
                  // );
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>));
                },
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.grey,
                  size: 16.h,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
