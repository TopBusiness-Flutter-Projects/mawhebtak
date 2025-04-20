import 'package:easy_localization/easy_localization.dart';

import '../../../core/exports.dart';
import '../../events/screens/widgets/custom_apply_app_bar.dart';

class WritePost extends StatelessWidget {
  const WritePost({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body:
    Column(children: [
      CustomAppBarWithClearWidget(title:  "share_post".tr(),),

    ],),);
  }
}
