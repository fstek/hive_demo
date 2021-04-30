//import 'package:hive/hive.dart';

class BoxManager {
  static BoxManager? _instance;
  static BoxManager get instance {
    _instance ??= BoxManager._init();
    return _instance!;
  }

  BoxManager._init();

  final boxNameLanguage = 'language';
  final keyLanguageCode = 'languageCode';
  final keyCountryCode = 'countryCode';

  final boxNameTheme = 'theme';
  final keyLightTheme = 'lightTheme';
}
