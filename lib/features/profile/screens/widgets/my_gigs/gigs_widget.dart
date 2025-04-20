import '../../../../../core/exports.dart';
import '../time_line_widget/time_line_list.dart';

class GigsWidget extends StatelessWidget {
  const GigsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
      return TimeLineList();
    }, separatorBuilder: (BuildContext context, int index) {
      return SizedBox(height: 15.h,); },);
  }
}
