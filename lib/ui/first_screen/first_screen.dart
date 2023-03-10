import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:redux/redux.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localized = AppLocalizations.of(context)!;
    return StoreConnector(
      builder: (BuildContext context, vm) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('First Page'),
            actions: [
              PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (_) => [
                  const PopupMenuItem(
                    value: 'First action',
                    child: Text('First action'),
                  ),
                  const PopupMenuItem(
                    value: 'Second action',
                    child: Text('Second action'),
                  ),
                ],
                onSelected: (value) {},
              ),
            ],
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(localized.testString),
              const Text('First screen'),
              const SizedBox(
                height: 8,
              ),
              OutlinedButton(
                onPressed: vm,
                child: const Text('Go to second screen'),
              )
            ],
          ),
        );
      },
      converter: (Store<AppState> store) {
        return () {
          store.dispatch(const NavigationAction.push(AppRoute.third()));
        };
      },
    );
  }
}
