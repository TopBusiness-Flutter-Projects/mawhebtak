

import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/auth/new_account/cubit/new_account_state.dart';
import 'package:mawhebtak/features/auth/new_account/data/repos/new_account.repo.dart';

class NewAccountCubit extends Cubit<NewAccountState> {
  NewAccountCubit(this.exRepo) : super(NewAccountInitial());
  NewAccountRepo exRepo ;
}
