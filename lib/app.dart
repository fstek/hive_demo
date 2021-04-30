import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view.dart';
import 'provider/language_provider.dart';
import 'provider/theme_provider.dart';
import 'i18n/language_manager.dart';
import 'utils/theme_manager.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LanguageProvider>().locale;
    final lightTheme = context.watch<ThemeProvider>().lightTheme;

    return MaterialApp(
      /// [supportedLocales]: Desteklenen Diller
      supportedLocales: LanguageManager.instance.supportedLocales,

      /// [Delegate: Temsilci] listesi
      localizationsDelegates: LanguageManager.instance.localizationsDelegates,

      /// Uygulamanın başlatılacağı dil
      locale: locale,

      /// Uygulamanın teması
      theme: lightTheme ? ThemeManager.instance.light : ThemeManager.instance.dark,

      home: View(),
    );
  }
}
