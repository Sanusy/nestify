import 'package:get_it/get_it.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/logger/logger_middleware.dart';
import 'package:nestify/redux/login/login_with_google_middleware.dart';
import 'package:nestify/redux/navigation/navigation_middleware.dart';
import 'package:redux/redux.dart';

final _serviceLocator = GetIt.instance;

List<Middleware<AppState>> appMiddleware = [
  LoggerMiddleware(),
  NavigationMiddleware(_serviceLocator.get()),
  LoginWithGoogleMiddleware(_serviceLocator.get()),
];
