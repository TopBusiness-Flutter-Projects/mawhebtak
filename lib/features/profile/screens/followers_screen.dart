import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/features/profile/cubit/profile_cubit.dart';
import 'package:mawhebtak/features/profile/screens/widgets/followers_widget.dart';
import '../../../core/exports.dart';
import '../../events/screens/widgets/custom_apply_app_bar.dart';

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit=context.read<ProfileCubit>();
    return  BlocBuilder<ProfileCubit,ProfileState>(builder: (BuildContext context, state) {
      return  Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CustomAppBarWithClearWidget(title:  "followers".tr(),),
              SizedBox(height: 10.h,),
          ListView.separated(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
            return  FollowersWidget();
                }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 5.h,) ;},),
          SizedBox(height: 100,)
            ],

          ),
        ),
      );

    },);
  }
}
