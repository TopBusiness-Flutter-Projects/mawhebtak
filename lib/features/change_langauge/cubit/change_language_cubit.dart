

import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/change_langauge/cubit/change_language_state.dart';
import 'package:mawhebtak/features/change_langauge/data/repos/change_language_repo.dart';

class ChangeLanguageCubit extends Cubit<ChangeLanguageState> {
  ChangeLanguageCubit(this.exRepo) : super(ChangeLanguageInitial());
  ChangeLanguageRepo exRepo ;
}
