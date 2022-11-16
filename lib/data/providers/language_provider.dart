import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale("it");

  Locale get getLocale => _locale;

  set setLocale(Locale locale) {
    if (!AppLocalizations.supportedLocales.contains(locale)) {
      return;
    }

    _locale = locale;
    notifyListeners();
  }

  void toggleLanguage() {
    if (_locale.languageCode == "en") {
      _locale = const Locale("it");
    } else {
      _locale = const Locale("en");
    }

    notifyListeners();
  }
}
