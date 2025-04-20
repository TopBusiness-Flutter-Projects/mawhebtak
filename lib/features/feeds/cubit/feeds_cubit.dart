import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'feeds_state.dart';

class FeedsCubit extends Cubit<FeedsState> {
  FeedsCubit() : super(FeedsInitial());
}
