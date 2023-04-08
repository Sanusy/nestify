import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/navigation/navigation_service.dart';
import 'package:nestify/service/user_service/user_service.dart';

class BottomNavigationScreen extends StatelessWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: OutlinedButton(
          onPressed: () async {
            final navigationService = GetIt.instance.get<UserService>();
            await navigationService.logOut();
            GetIt.instance
                .get<NavigationService>()
                .replace(const AppRoute.login());
          },
          child: const Text('Logout'),
        ),
      ),
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
