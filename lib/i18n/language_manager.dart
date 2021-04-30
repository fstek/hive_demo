import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_demo/i18n/app_localizations.dart';

class LanguageManager {
  static LanguageManager? _instance;
  static LanguageManager get instance {
    _instance ??= LanguageManager._init();
    return _instance!;
  }

  LanguageManager._init();

  final assetsPathLanguage = 'assets/languages';
  final enLocale = Locale('en', 'US');
  final trLocale = Locale('tr', 'TR');

  List<Locale> get supportedLocales => [enLocale, trLocale];

  List<LocalizationsDelegate> get localizationsDelegates => [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];

  List<String> get supportedLanguageCode => [enLocale.languageCode, trLocale.languageCode];
}
