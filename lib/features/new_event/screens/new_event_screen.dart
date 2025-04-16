import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/features/events/screens/widgets/custom_apply_app_bar.dart';
import '../../../core/exports.dart';

class NewEventScreen extends StatelessWidget {
  const NewEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(children: [
        CustomAppBarWithClearWidget(title: "new_event".tr()),

      ])),
    );
  }
}
