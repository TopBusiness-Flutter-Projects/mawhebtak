import 'package:mawhebtak/features/change_langauge/cubit/change_language_cubit.dart';
import 'package:mawhebtak/features/change_langauge/cubit/change_language_state.dart';
import '../../../core/exports.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key, required this.isLocal});
  final bool isLocal;
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ChangeLanguageCubit>();
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: AppColors.grayLite,
          child: Column(
            children: [
              CustomSimpleAppbar(title: "change_language".tr()),
              SizedBox(
                height: 10.h,
              ),
              BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
                  builder: (context, state) {
                return Container(
                  color: AppColors.grayLite,
                  child: Padding(
                    padding:
                        EdgeInsets.only(right: 15.w, left: 15.w, bottom: 20.h),
                    child: Column(
                      children: [
                        changeLanguageContainer(
                          text: "English",
                          onTap: () {
                            (isLocal == true)
                                ? cubit.changeLanguageLocal(context, "English")
                                : cubit.changeLanguage(context, "English");
                          },
                        ),
                        changeLanguageContainer(
                          text: "اللغة العربية",
                          onTap: () {
                            (isLocal == false)
                                ? cubit.changeLanguageLocal(context, "Arabic")
                                : cubit.changeLanguage(context, "Arabic");
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

GestureDetector changeLanguageContainer({
  required String text,
  required void Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Container(
        padding:
            EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h, top: 15.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r), color: AppColors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w400),
            ),
            GestureDetector(
              onTap: onTap,
              child: Icon(
                Icons.arrow_forward_ios_sharp,
                color: AppColors.primary,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
