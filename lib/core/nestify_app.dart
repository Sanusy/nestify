import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nestify/core/styles/app_theme.dart';
import 'package:nestify/navigation/implementation/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NestifyApp extends StatelessWidget {
  const NestifyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: appTheme,
      routerConfig: goRouter,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales:AppLocalizations.supportedLocales,
    );
  }
}
