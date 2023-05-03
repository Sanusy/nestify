import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/core/styles/app_theme.dart';
import 'package:nestify/navigation/implementation/routes.dart';

class NestifyApp extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  const NestifyApp({
    Key? key,
    required this.scaffoldMessengerKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: scaffoldMessengerKey,
      theme: appTheme,
      routerConfig: goRouter,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
