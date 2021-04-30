import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../utils/box_manager.dart';
import '../utils/log_mixin.dart';

class ThemeProvider extends ChangeNotifier with LogMixin {
  ThemeProvider() {
    _lightTheme = true;
    _initTheme();
  }

  final Box<bool> _boxTheme = Hive.box<bool>(BoxManager.instance.boxNameTheme);

  /// Theme
  late bool _lightTheme;

  /// Getter Theme
  bool get lightTheme => _lightTheme;

  /// Setter Theme: Dili [DEĞİŞTİR]
  set setTheme(bool newValue) {
    if (newValue == _lightTheme) return;

    /// Değiştirilen temayı değişkene [ATA]
    _lightTheme = newValue;
    log('Tema değeri "${_lightTheme == true ? 'Light Theme' : 'Dark Theme'}" olarak değiştirildi');

    /// Dil değişikliğini [KAYDET]
    _saveTheme(newValue);
    notifyListeners();
  }

  /// Save Theme: Theme değişikliğini Hive ile [KAYDET]
  void _saveTheme(bool newValue) {
    /// Write Box - Dil Kodunu Kutuya [YAZ/KAYDET]
    _boxTheme.put(
      BoxManager.instance.keyLightTheme,
      newValue,
    );

    log('Tema değeri "${_lightTheme == true ? 'Light Theme' : 'Dark Theme'}" olarak kaydedildi');
  }

  /// Initialize Theme: Uygulama Açıldığında Temayı Yükle
  void _initTheme() {
    /// Read Box - Dil Kodunu Kutudan [OKU/GETİR]
    var _getLightTheme = _boxTheme.get(
      BoxManager.instance.keyLightTheme,
      defaultValue: true,
    );

    /// Kutudaki değerleri _locale değişkenine [ATA]
    _lightTheme = _getLightTheme!;

    notifyListeners();
    log(
      'Uygulamanın başlangıç teması: "${_getLightTheme == true ? 'Light Theme' : 'Dark Theme'}"',
    );
  }
}
