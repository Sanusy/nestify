import 'package:get_it/get_it.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/logger/logger_middleware.dart';
import 'package:nestify/redux/middleware/create_home_middleware.dart';
import 'package:nestify/redux/middleware/login_with_google_middleware.dart';
import 'package:nestify/redux/middleware/logout_middleware.dart';
import 'package:nestify/redux/middleware/create_home_pick_home_avatar_middleware.dart';
import 'package:nestify/redux/middleware/create_home_pick_user_avatar_middleware.dart';
import 'package:nestify/redux/navigation/navigation_middleware.dart';
import 'package:redux/redux.dart';

final _serviceLocator = GetIt.instance;

List<Middleware<AppState>> appMiddleware = [
  LoggerMiddleware(),
  NavigationMiddleware(_serviceLocator.get()),
  LoginWithGoogleMiddleware(_serviceLocator.get()),
  LogoutMiddleware(_serviceLocator.get()),
  CreateHomePickHomeAvatarMiddleware(_serviceLocator.get()),
  CreateHomeMiddleware(
    _serviceLocator.get(),
    _serviceLocator.get(),
    _serviceLocator.get(),
  ),
  CreateHomePickUserAvatarMiddleware(_serviceLocator.get()),
];
