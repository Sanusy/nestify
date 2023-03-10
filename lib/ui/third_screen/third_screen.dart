import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/navigation/navigation_service.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Page'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Third screen'),
          const SizedBox(
            height: 8,
          ),
          MaterialButton(
            onPressed: () {
              GetIt.instance
                  .get<NavigationService>()
                  .replace(AppRoute.second());
            },
            child: const Text('Pop'),
          )
        ],
      ),
    );
  }
}
