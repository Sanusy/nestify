import 'package:flutter/material.dart';
import 'package:nestify/core/styles/app_theme.dart';
import 'package:nestify/navigation/implementation/routes.dart';

class NestifyApp extends StatelessWidget {
  const NestifyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: appTheme,
      routerConfig: goRouter,
    );
  }
}
