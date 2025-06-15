import 'package:mawhebtak/core/exports.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/preferences/preferences.dart';
import '../../auth/login/data/models/login_model.dart';
import '../../home/data/models/home_model.dart';
import '../cubit/chat_cubit.dart';
import '../cubit/chat_state.dart';
import 'message_screen.dart';

//! TEST CHAT  |
//! SHOW CHAT IN SIDE BAR
class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key});

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  void initState() {
    getUserData();
    context.read<ChatCubit>().getChatRooms();
    print('RoomScreen');
    super.initState();
  }

  LoginModel? userModel;
  void getUserData() async {
    userModel = await Preferences.instance.getUserModel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        var cubit = context.read<ChatCubit>();
        return Scaffold(
          appBar: AppBar(
            title: Text('chats'.tr()),
          ),
          body: (state is LoadingCreateChatRoomState)
              ? const Center(child: RefreshProgressIndicator())
              : (state is ErrorCreateChatRoomState)
                  ? const Center(child: CircularProgressIndicator())
                  : cubit.chatRoomModel?.data?.length == 0
                      ? Center(
                          child: Text(
                            'no_rooms'.tr(),
                            style: getRegularStyle(),
                          ),
                        )
                      : ListView.builder(
                          itemCount: cubit.chatRoomModel?.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            TopTalent? user = (userModel?.data?.id
                                            ?.toString() ==
                                        cubit.chatRoomModel?.data?[index]
                                            .receiver?.id
                                            ?.toString() ??
                                    false)
                                ? (cubit.chatRoomModel?.data?[index].sender)
                                : (cubit.chatRoomModel?.data?[index].receiver);
                            return Material(
                              color: Colors.white,
                              shadowColor: Colors.grey,
                              elevation: 1,
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0, vertical: 0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(user?.image ?? ''),
                                      ),
                                      Flexible(
                                          child: Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 8.0),
                                        child: Text(
                                          user?.name ?? '',
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  //!
                                  Navigator.pushNamed(
                                    context,
                                    Routes.messageRoute,
                                    arguments: MainUserAndRoomChatModel(
                                        chatId: cubit.chatRoomModel
                                            ?.data?[index].roomToken
                                            .toString()),
                                  );

                                  //
                                },
                              ),
                            );
                          }),
        );
      },
    );
  }
}
