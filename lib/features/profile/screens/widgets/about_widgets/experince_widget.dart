import 'package:mawhebtak/features/profile/data/models/profile_model.dart';

import '../../../../../core/exports.dart';

class ExperinceWidget extends StatefulWidget {
  const ExperinceWidget({super.key, required this.experience});
  final Experience experience;

  @override
  State<ExperinceWidget> createState() => _ExperinceWidgetState();
}

class _ExperinceWidgetState extends State<ExperinceWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 10.h,),
      Padding(
        padding:  EdgeInsets.only(left: 16.0.w,right: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(ImageAssets.experience),
            SizedBox(width: 5.w,),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.experience.title ?? "",style: getMediumStyle(fontSize: 13.sp),),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.experience.description ?? "",
                    maxLines: _expanded ? null : 3,
                    overflow: TextOverflow.fade,
                    style: getRegularStyle(
                      color: AppColors.grayText3,
                      fontSize: 14.sp,
                    ),
                  ),
                  if (  widget.experience.description!.length > 100) // adjust based on your needs
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _expanded = !_expanded;
                        });
                      },
                      child: Text(
                        _expanded ? 'See Less' : 'See All',
                        style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                      ),
                    ),
                ],
              ),
                ],
              ),
            )
          ],),

      ),
      SizedBox(height: 4.h,),
      Container(height: 2.h,color: AppColors.grayLite,width: double.infinity,),
    ],);
  }
}
