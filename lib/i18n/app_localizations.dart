import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'language_manager.dart';
import '../utils/log_mixin.dart';

class AppLocalizations with LogMixin {
  AppLocalizations(this.locale);

  late final Locale locale;

  /// MaterialApp'tan delegate'e erişim için
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  late Map<String, String> _localizedStrings;
  Future<bool> load() async {
    /// Dil dosyalarımızın bulunduğu dosya yolu. "assets/languages"
    /// .json uzantılı dosyaların dilKodu-ülkeKodu.json
    var jsonString = await rootBundle.loadString('${LanguageManager.instance.assetsPathLanguage}/${locale.languageCode}_${locale.countryCode}.json');
    log('Dil dosyaları ${LanguageManager.instance.assetsPathLanguage} dosya yolundan yüklendi');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    return _localizedStrings[key]!;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    /// Destekelenecek olan dillerin kodu buraya ekle.
    return LanguageManager.instance.supportedLanguageCode.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    /// AppLocalizations sınıfının, JSON yüklemesinin gerçekte çalıştığı yer
    var localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

/// Ek
extension AppLocalizationExtension on BuildContext {
  String translate(String key) => AppLocalizations.of(this)!.translate(key);

  /// Kullanımı: context.translate('home'),
}
