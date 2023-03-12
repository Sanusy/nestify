import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:get_it/get_it.dart';
import 'package:nestify/core/nestify_app.dart';
import 'package:nestify/navigation/implementation/go_route_navigation_service.dart';
import 'package:nestify/navigation/implementation/routes.dart';
import 'package:nestify/navigation/navigation_service.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/middleware.dart';
import 'package:nestify/redux/reducer.dart';
import 'package:nestify/service/user_service/firebase_user_service.dart';
import 'package:nestify/service/user_service/user_service.dart';
import 'package:redux/redux.dart';

enum Environment {
  dev,
  prod,
}

class AppConfiguration {
  final Environment environment;

  AppConfiguration({
    required this.environment,
  });

  Future<void> _initializeDependencies() async {
    await Firebase.initializeApp();

    final serviceLocator = GetIt.instance;

    serviceLocator.registerSingleton<NavigationService>(
      GoRouteNavigationService(goRouter),
    );
    serviceLocator.registerSingleton<UserService>(FirebaseUserService());

    await serviceLocator.allReady();
  }

  Store<AppState> _createStore() => Store(
        appReducer,
        initialState: AppState.initial(),
        middleware: appMiddleware,
      );

  Future<void> run() async {
    WidgetsFlutterBinding.ensureInitialized();
    await _initializeDependencies();

    runApp(
      StoreProvider(
        store: _createStore(),
        child: const NestifyApp(),
      ),
    );
  }
}
