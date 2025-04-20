import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'announcement_state.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  AnnouncementCubit() : super(AnnouncementInitial());
}
