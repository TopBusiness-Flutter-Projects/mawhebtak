import 'package:easy_localization/easy_localization.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mawhebtak/core/preferences/hive/hive.dart';
import 'package:mawhebtak/core/preferences/hive/models/work_model.dart';
import 'package:mawhebtak/injector.dart' as injector;
import 'app_bloc_observer.dart';
import 'core/exports.dart';
import 'core/preferences/preferences.dart';

Future<void> initialization() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Preferences.instance.init();
  await injector.setupCubit();
  await injector.setupRepo();
  await injector.setupSharedPreferences();
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await WorkHiveManager.initialize();
  await Hive.initFlutter();
}
