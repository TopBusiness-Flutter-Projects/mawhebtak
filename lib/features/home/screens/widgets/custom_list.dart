import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/features/home/cubit/home_cubit.dart';
import 'package:mawhebtak/features/home/cubit/home_state.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/exports.dart';
import '../home_screen.dart';

class CustomList extends StatelessWidget {
  const CustomList({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit=context.read<HomeCubit>();
  return BlocBuilder<HomeCubit,HomeState>(builder: (BuildContext context, state) { return         Positioned(
    bottom: 15,
    left: 0,
    right: 0,

    child: SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount:cubit.items.length,
        shrinkWrap: true,
        // controller: BouncingScrollPhysics(),
        //  padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              cubit.items[index].label=="Jobs"? Navigator.pushNamed(context, Routes.eventScreen):
              cubit.items[index].label=="Jobs"?  Navigator.pushNamed(context, Routes.eventScreen):Navigator.pushNamed(context, Routes.profileScreen);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 71.h,
                      width: 68.w,
                      decoration: BoxDecoration(
                        color: AppColors.blueMeduim,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.grayDark,width: 2),
                      ),
                      child: Center(
                        child: Icon(
                       cubit.   items[index].icon,
                          color: Colors.cyanAccent,
                        ),
                      ),
                    ),
                  ),
                  AutoSizeText(
                   cubit. items[index].label,
                    style: getMediumStyle(fontSize: 14.sp,color: AppColors.white),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  ); },);
  }
}
