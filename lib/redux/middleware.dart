import 'package:get_it/get_it.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/logger/logger_middleware.dart';
import 'package:nestify/redux/middleware/create_home_draft_middleware.dart';
import 'package:nestify/redux/middleware/create_home_middleware.dart';
import 'package:nestify/redux/middleware/discard_create_home_middleware.dart';
import 'package:nestify/redux/middleware/login_with_google_middleware.dart';
import 'package:nestify/redux/middleware/logout_middleware.dart';
import 'package:nestify/redux/middleware/pick_create_home_avatar_middleware.dart';
import 'package:nestify/redux/middleware/pick_create_user_profile_avatar_middleware.dart';
import 'package:nestify/redux/navigation/navigation_middleware.dart';
import 'package:redux/redux.dart';

final _serviceLocator = GetIt.instance;

List<Middleware<AppState>> appMiddleware = [
  LoggerMiddleware(),
  NavigationMiddleware(_serviceLocator.get()),
  LoginWithGoogleMiddleware(_serviceLocator.get()),
  LogoutMiddleware(_serviceLocator.get()),
  CreateHomeDraftMiddleware(_serviceLocator.get()),
  DiscardCreateHomeMiddleware(_serviceLocator.get()),
  PickCreateHomeAvatarMiddleware(_serviceLocator.get()),
  CreateHomeMiddleware(
    _serviceLocator.get(),
    _serviceLocator.get(),
    _serviceLocator.get(),
  ),
  PickCreateUserProfileAvatarMiddleware(_serviceLocator.get()),
];
