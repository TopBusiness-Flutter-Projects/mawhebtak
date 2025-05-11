import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mawhebtak/core/preferences/hive/hive.dart';
import 'package:mawhebtak/core/preferences/hive/models/work_model.dart';
import 'package:mawhebtak/injector.dart' as injector;
import 'app_bloc_observer.dart';
import 'core/exports.dart';
import 'core/notification_services/notification_service.dart';
import 'core/preferences/preferences.dart';
import 'firebase_options.dart';

NotificationService? notificationService;
Future<void> initialization() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  notificationService = NotificationService();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Preferences.instance.init();
  await injector.setupCubit();
  await injector.setupRepo();
  await injector.setupSharedPreferences();
  Bloc.observer = AppBlocObserver();

  await Hive.initFlutter();
  Hive.registerAdapter(WorkModelAdapter());
  Hive.registerAdapter(AssistantAdapter());
  await Hive.openBox(WorkHiveManager.workBoxName);
}
