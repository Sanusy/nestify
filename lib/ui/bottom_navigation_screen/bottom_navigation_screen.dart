import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomNavigationScreen extends StatelessWidget {
  final Widget screen;

  const BottomNavigationScreen({Key? key, required this.screen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      body: screen,
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            label: localization.bottomNavigationHome,
          ),
          NavigationDestination(
            icon: const Icon(Icons.home_repair_service_outlined),
            label: localization.bottomNavigationHomeProfile,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            label: localization.bottomNavigationSettings,
          ),
        ],
      ),
    );
  }
}
