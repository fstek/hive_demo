import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../utils/box_manager.dart';
import '../utils/log_mixin.dart';

class LanguageProvider extends ChangeNotifier with LogMixin {
  LanguageProvider() {
    _initLocale();
  }

  /// Açılan Kutuyu ÇAĞIR
  final Box<String> _boxLanguage = Hive.box<String>(BoxManager.instance.boxNameLanguage);

  /// Locale: Varsayılan Locale değeri
  var _locale = Locale(window.locale.languageCode, window.locale.countryCode);

  /// Getter Locale
  Locale get locale => _locale;

  /// Setter Locale: Dili [DEĞİŞTİR]
  void setLocale(String languageCode, String countryCode) {
    /// Girilen ile Mevcut değer aynı ise [DEĞİŞİKLİK YAPMA] yani notifyListeners çalışmasın
    if (_locale.languageCode == languageCode && _locale.countryCode == countryCode) return;

    /// Değiştirilen dili değişkene [ATA]
    _locale = Locale(languageCode, countryCode);
    log('Dil "$_locale" olarak değiştirildi');

    /// Dil değişikliğini [KAYDET]
    _saveLocale(languageCode, countryCode);
    notifyListeners();
  }

  /// Save Locale: Dil değişikliğini Hive ile [KAYDET]
  void _saveLocale(String languageCode, String countryCode) {
    /// Write Box - Dil Kodunu Kutuya [YAZ/KAYDET]
    _boxLanguage.put(
      BoxManager.instance.keyLanguageCode,
      languageCode,
    );

    /// Write Box - Ülke Kodunu Kutuya [YAZ/KAYDET]
    _boxLanguage.put(
      BoxManager.instance.keyCountryCode,
      countryCode,
    );
    log('Dil "$languageCode-$countryCode" olarak kaydedildi');
  }

  /// Initialize Locale: Uygulama Açıldığında Dili Yükle
  void _initLocale() {
    log('Localization (Yerelleştirme) başlatıldı');

    /// Read Box - Dil Kodunu Kutudan [OKU/GETİR]
    var _getLanguageCode = _boxLanguage.get(
      BoxManager.instance.keyLanguageCode,
      defaultValue: window.locale.languageCode,
    );

    /// Read Box - Ülke Kodunu Kutudan [OKU/GETİR]
    var _getCountryCode = _boxLanguage.get(
      BoxManager.instance.keyCountryCode,
      defaultValue: window.locale.countryCode,
    );

    /// Cihazın varsayılan dili ile desteklenen diller arasında ise yükleme yapma
    if (_locale.languageCode == _getLanguageCode && _locale.countryCode == _getCountryCode) {
      log(
        'Uygulama cihazın varsayılan dili ile açıldı: ${_locale.languageCode}-${_locale.countryCode}',
      );
      return;
    }

    /// Kutudaki değerleri _locale değişkenine [ATA]
    _locale = Locale(
      _getLanguageCode!,
      _getCountryCode!,
    );

    notifyListeners();
    log(
      'Uygulamanın başlangıç dili: "$_getLanguageCode-$_getCountryCode" ',
    );
  }
}
