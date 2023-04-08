import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/navigation/navigation_service.dart';
import 'package:nestify/service/user_service/user_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home screen'),
            OutlinedButton(
              onPressed: () async {
                final navigationService = GetIt.instance.get<UserService>();
                await navigationService.logOut();
                GetIt.instance
                    .get<NavigationService>()
                    .replace(const AppRoute.login());
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
