import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/features/home/cubits/home_cubit/home_cubit.dart';
import 'package:mawhebtak/features/home/cubits/home_cubit/home_state.dart';
import 'package:mawhebtak/features/home/screens/widgets/notification_widget.dart';
import '../../../core/exports.dart';


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
 return BlocBuilder<HomeCubit, HomeState>(builder: (BuildContext context, state) {    return Scaffold(
   body: Column(
     children: [
       SizedBox(height: 20.h,),
       CustomSimpleAppbar(title: 'notification'.tr()),
       Expanded(
         child: ListView.separated(
           shrinkWrap: true,


           itemCount: 30,
           itemBuilder: (BuildContext context, int index) {
             return    NotificationWidget(); }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 10.h,); },),
       )

     ],
   ),
 ); },);
  }
}
