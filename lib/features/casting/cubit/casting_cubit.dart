

import 'package:mawhebtak/core/exports.dart';

import '../../home/screens/home_screen.dart';
import '../data/repos/casting.repo.dart';
import 'casting_state.dart';

class CastingCubit extends Cubit<CastingState> {
  CastingCubit(this.exRepo) : super(CastingInitial());
  CastingRepo exRepo ;
  final List<HomeItem> items = [


    HomeItem(icon:AppIcons.eventIcon, label: 'Events'),
    HomeItem(icon:AppIcons.aboutUs, label: 'Casting'),
    HomeItem(icon: AppIcons.announceIcon, label: 'Announce'),
    HomeItem(icon: AppIcons.jopIcon, label: 'Jobs'),
    HomeItem(icon: AppIcons.assistantIcon, label: 'Assistant'),

  ];
}
