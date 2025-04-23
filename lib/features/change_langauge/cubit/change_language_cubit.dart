

import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:mawhebtak/features/change_langauge/cubit/change_language_state.dart';
import 'package:mawhebtak/features/change_langauge/data/repos/change_language_repo.dart';

import '../../../core/preferences/preferences.dart';
import '../../../core/utils/restart_app_class.dart';

class ChangeLanguageCubit extends Cubit<ChangeLanguageState> {
  ChangeLanguageCubit(this.exRepo) : super(ChangeLanguageInitial());
  ChangeLanguageRepo exRepo ;
  void changeLanguage(BuildContext context, String newLanguage) {
    // selectedLanguage = newLanguage; // Update the selected language

    // Map of language display names to their codes
    final Map<String, String> languageCodes = {
      'Arabic': 'ar',
      'English': 'en',
      'German': 'de',
      'Italian': 'it',
      'Korean': 'ko',
      'Russian': 'ru',
      'Spanish': 'es'
    };

    // Get the language code from the map
    final String langCode = languageCodes[newLanguage] ?? 'en';

    // Set the locale
    context.setLocale(Locale(langCode));
    // Save the language preference
    Preferences.instance.savedLang(langCode);
    Preferences.instance.getSavedLang();
    //Restart.restartApp();

    HotRestartController.performHotRestart(context);
//Navigator.push(context, MaterialPageRoute(builder: (context) => const SplashScreen()));
    print("change lang and restart");

    emit(AccountLanguageChanged()); // Emit a new state to notify the UI

  }

}
