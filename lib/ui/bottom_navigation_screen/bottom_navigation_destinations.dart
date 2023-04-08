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

    switch (this) {
      case BottomNavigationDestination.home:
        return NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          label: localization.bottomNavigationHome,
        );
      case BottomNavigationDestination.homeProfile:
        return NavigationDestination(
          icon: const Icon(Icons.home_repair_service_outlined),
          label: localization.bottomNavigationHomeProfile,
        );
      case BottomNavigationDestination.settings:
        return NavigationDestination(
          icon: const Icon(Icons.settings_outlined),
          label: localization.bottomNavigationSettings,
        );
    }
  }

  AppRoute get route {
    switch (this) {
      case BottomNavigationDestination.home:
        return const AppRoute.home();
      case BottomNavigationDestination.homeProfile:
        return const AppRoute.homeProfile();
      case BottomNavigationDestination.settings:
        return const AppRoute.settings();
    }
  }
}
