
import 'package:mawhebtak/core/preferences/preferences.dart';
import 'package:mawhebtak/core/utils/check_login.dart';
import 'package:mawhebtak/core/widgets/show_loading_indicator.dart';
import 'package:mawhebtak/features/events/screens/widgets/custom_apply_app_bar.dart';
import 'package:mawhebtak/features/packages/cubit/state.dart';
import '../../../core/exports.dart';
import '../cubit/cubit.dart';
import 'widget/package_item_widget.dart';
class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});


  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  @override
  void initState() {
    context.read<PackagesCubit>().getPackagesData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<PackagesCubit, PackagesState>(
          builder: (context, state) {
            var cubit = context.read<PackagesCubit>();
        
            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBarWithClearWidget(
                      title: 'packages'.tr(),
                    ),
                    5.h.verticalSpace,
                    Flexible(
                      child: (state is LoadingGetPackagesState)
                          ? const Center(child: CustomLoadingIndicator())
                          : ListView.builder(
                         shrinkWrap: true,
                         itemCount: cubit.packagesModel?.data?.length,
                        itemBuilder: (context, index) {
                         var item = cubit.packagesModel?.data?[index];
                          return PackageItemWidget(
                           item: item,
                            onTap: () async {
                              bool? confirm = await  showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    insetPadding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 24.h),
                                    child: Padding(
                                      padding: EdgeInsets.all(20.w),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.info_outline, color: AppColors.primary, size: 48.sp),
                                          SizedBox(height: 16.h),
                                          Text(
                                            'confirm'.tr(),
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                          SizedBox(height: 12.h),
                                          Text(
                                            'are_you_sure_you_want_to_choose_this_package'.tr(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                                          ),
                                          SizedBox(height: 24.h),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: TextButton(
                                                  onPressed: () => Navigator.of(context).pop(false),
                                                  style: TextButton.styleFrom(
                                                    foregroundColor: AppColors.primary,
                                                    padding: EdgeInsets.symmetric(vertical: 12.h),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      side: BorderSide(color: AppColors.primary),
                                                    ),
                                                  ),
                                                  child: Text('cancel'.tr()),
                                                ),
                                              ),
                                              SizedBox(width: 12.w),
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () async {
                                                    final user = await Preferences.instance.getUserModel();
                                                    if (user.data?.token == null) {
                                                      checkLogin(context);
                                                    } else {
                                                      cubit.subscribeToPackage(
                                                        context: context,
                                                        packageId: cubit.packagesModel?.data?[index].id.toString() ?? '',
                                                      );
                                                    }
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: AppColors.primary,
                                                    padding: EdgeInsets.symmetric(vertical: 12.h),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                  ),
                                                  child: Text('confirm'.tr(), style: TextStyle(color: Colors.white)),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );


                            },
        
                          );
                        },
                      ),
                    ),
                  ],
                ),
                // Show loading overlay when package is being added
                // if (state is LoadingAddAdOfferPackageToLawyerState)
                //   Positioned.fill(
                //     child: Container(
                //       color: Colors.black.withOpacity(0.3),
                //       child:Center(
                //         child: Lottie.asset(
                //           'assets/icons/Animation - 1744329876055.json',
                //           width: 100.w,
                //           height: 100.h,
                //           fit: BoxFit.contain,
                //         ),
                //       ),
                //     ),
                //   ),
              ],
            );
          },
        ),
      ),
    );
  }

}
