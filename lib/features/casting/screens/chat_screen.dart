import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/exports.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomSimpleAppbar(title: "chat".tr()),
        ],
      ),
    );
  }
}
