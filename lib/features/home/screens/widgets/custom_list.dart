import 'package:auto_size_text/auto_size_text.dart';

import '../../../../core/exports.dart';
import '../home_screen.dart';

class CustomList extends StatelessWidget {
  const CustomList({super.key});

  @override
  Widget build(BuildContext context) {
    return      Positioned(
      bottom: 15,
      left: 0,
      right: 0,

      child: SizedBox(
        height: 130,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount:items.length,
          shrinkWrap: true,
          // controller: BouncingScrollPhysics(),
          //  padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            return Padding(
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
                          items[index].icon,
                          color: Colors.cyanAccent,
                        ),
                      ),
                    ),
                  ),
                  AutoSizeText(
                    items[index].label,
                    style: getMediumStyle(fontSize: 14.sp,color: AppColors.white),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
