import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/navigation/navigation_service.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('First Page'),),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('First screen'),
          const SizedBox(
            height: 8,
          ),
          MaterialButton(
            onPressed: () {
              GetIt.instance.get<NavigationService>().setPath(AppRoute.third());
            },
            child: const Text('Go to second screen'),
          )
        ],
      ),
    );
  }
}
