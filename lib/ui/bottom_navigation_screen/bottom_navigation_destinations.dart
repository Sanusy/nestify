import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/navigation/app_route.dart';

enum BottomNavigationDestination {
  home,
  homeProfile,
  settings,
}

extension BottomNavigationDestinationExtenstions
    on BottomNavigationDestination {
  NavigationDestination destination(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return switch (this) {
      BottomNavigationDestination.home => NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          label: localization.bottomNavigationHome,
        ),
      BottomNavigationDestination.homeProfile => NavigationDestination(
          icon: const Icon(Icons.home_repair_service_outlined),
          label: localization.bottomNavigationHomeProfile,
        ),
      BottomNavigationDestination.settings => NavigationDestination(
          icon: const Icon(Icons.settings_outlined),
          label: localization.bottomNavigationSettings,
        ),
    };
  }

  AppRoute get route {
    return switch (this) {
      BottomNavigationDestination.home => HomeRoute(),
      BottomNavigationDestination.homeProfile => HomeProfileRoute(),
      BottomNavigationDestination.settings => SettingsRoute(),
    };
  }
}
