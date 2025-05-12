import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ss_state.dart';

class SsCubit extends Cubit<SsState> {
  SsCubit() : super(SsInitial());
}
