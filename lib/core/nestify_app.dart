import 'package:flutter/material.dart';
import 'package:nestify/core/styles/app_theme.dart';

class NestifyApp extends StatelessWidget {
  const NestifyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
    );
  }
}
