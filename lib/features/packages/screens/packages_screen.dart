
import 'package:easy_localization/easy_localization.dart';
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
    // context.read<PackagesCubit>().getAdOfferPackages();

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
                         itemCount: 3,
                        // itemCount: cubit.mainAdOfferPackagesModel?.data?.length,
                        itemBuilder: (context, index) {
                      //    var item = cubit.mainAdOfferPackagesModel?.data?[index];
                          return packageItemWidget(
                        //    item: item,
                            onTap: () async {
                              bool? confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('confirm'.tr()),
                                  content: Text('are_you_sure_you_want_to_choose_this_package'.tr()),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(false),
                                      child: Text('cancel'.tr()),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(true),
                                      child: Text('confirm'.tr()),
                                    ),
                                  ],
                                ),
                              );
        
                              if (confirm == true) {
                                // cubit.addAdOfferPackageToLawyer(
                                //   packageId: cubit.mainAdOfferPackagesModel?.data?[index].id.toString() ?? "",
                                // );
                              }
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
