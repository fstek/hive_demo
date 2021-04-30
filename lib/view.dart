import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'provider/language_provider.dart';
import 'provider/theme_provider.dart';
import 'i18n/app_localizations.dart';
import 'widgets/widgets.dart';

class View extends StatefulWidget {
  const View({Key? key}) : super(key: key);

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  @override
  Widget build(BuildContext context) {
    final language = context.read<LanguageProvider>();
    final theme = context.read<ThemeProvider>();
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: context.translate('choose_the_language'),
      ),
      body: _buildBody(context, language, theme),
    );
  }

  Center _buildBody(BuildContext context, LanguageProvider language, ThemeProvider theme) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.translate('home'),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () => language.setLocale('en', 'US'),
            child: Text(
              context.translate('english'),
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () => language.setLocale('tr', 'TR'),
            child: Text(
              context.translate('turkish'),
            ),
          ),
          const SizedBox(height: 15),
          Switch(
            value: theme.lightTheme,
            onChanged: (value) => theme.setTheme = value,
          ),
        ],
      ),
    );
  }
}
