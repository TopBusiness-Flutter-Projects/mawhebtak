

import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/assistant/cubit/assistant_state.dart';
import 'package:mawhebtak/features/assistant/data/repos/assistant.repo.dart';


class AssistantCubit extends Cubit<AssistantState> {
  AssistantCubit(this.exRepo) : super(AssistantInitial());
  AssistantRepo exRepo ;
  TextEditingController workNameController = TextEditingController();
}
