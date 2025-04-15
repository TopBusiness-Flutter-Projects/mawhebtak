import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/widgets/custom_simple_appbar.dart';

import '../../../core/exports.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Column(
          children: [
           CustomSimpleAppbar(title: "verification".tr()),
      
          ],
        ),
      ),
    );
  }
}
