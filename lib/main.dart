import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'provider/language_provider.dart';
import 'provider/theme_provider.dart';
import 'utils/box_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize Hive
  await Hive.initFlutter();

  /// Initialize Open Box - Kutu AÇ
  await Hive.openBox<String>(BoxManager.instance.boxNameLanguage);

  /// Initialize Open Box - Kutu AÇ
  await Hive.openBox<bool>(BoxManager.instance.boxNameTheme);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageProvider>(
          create: (context) => LanguageProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: const App(),
    ),
  );
}


/*
    EasyLocalization(
      /// Destekleyeceğimiz dillerin listesi.
      supportedLocales: LanguageManager.instance.supportedLocales,

      /// Dil dosyalarımızın bulunduğu dosya yolu.
      path: AppConstants.LANGUAGES_ASSETS_PATH,

      /// Cihazın dili destekleyeceğimiz diller arasında yoksa  hangi dil kullanılsın
      /// Varsayılan uygulama dili
      fallbackLocale: LanguageManager.instance.enLocale,
      child: App(),
    ),
*/