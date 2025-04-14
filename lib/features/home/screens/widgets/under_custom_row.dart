import '../../../../core/exports.dart';

class UnderCustomRow extends StatelessWidget {
  const UnderCustomRow({super.key});

  @override
  Widget build(BuildContext context) {
    return         Positioned(
      bottom: 50,
      // left: 30,
      child: SizedBox(
        width: getWidthSize(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 30.h,
                    width: 40.w,
                    child: Container(),
                  ),
                  Text("20 K followers", style: getMediumStyle(color: AppColors.white)),

                ],
              ),
            ),
            Spacer(), // ممكن تحط Spacer هنا بدلًا منه لو المكان يسمح
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 40.h,
                    width: 40.w,
                    child: Image.asset(ImageAssets.profileImage),
                  ),
                  Text("Ahmed Mokhtar", style: getMediumStyle(color: AppColors.white)),
                  Text("Ahmed Mokhtar", style: getMediumStyle(color: AppColors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    )
    ;
  }
}
