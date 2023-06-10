import 'package:get_it/get_it.dart';
import 'package:nestify/redux/add_member/middleware/obtain_invite_url_middleware.dart';
import 'package:nestify/redux/add_member/middleware/share_invite_middleware.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/common_middlewares/logout_middleware.dart';
import 'package:nestify/redux/create_home/middleware/create_home_middleware.dart';
import 'package:nestify/redux/create_home/middleware/create_home_pick_home_avatar_middleware.dart';
import 'package:nestify/redux/create_home/middleware/create_home_pick_user_avatar_middleware.dart';
import 'package:nestify/redux/create_home/middleware/load_available_colors_middleware.dart';
import 'package:nestify/redux/dynamic_links/dynamic_links_epic.dart';
import 'package:nestify/redux/home/middleware/init_home_middleware.dart';
import 'package:nestify/redux/home_profile/middleware/delete_home_middleware.dart';
import 'package:nestify/redux/join_home/middleware/init_join_home_middleware.dart';
import 'package:nestify/redux/join_home/middleware/join_home_middleware.dart';
import 'package:nestify/redux/join_home/middleware/join_home_pick_user_avatar_middleware.dart';
import 'package:nestify/redux/logger/logger_middleware.dart';
import 'package:nestify/redux/login/middleware/login_with_google_middleware.dart';
import 'package:nestify/redux/navigation/navigation_middleware.dart';
import 'package:nestify/redux/scan_qr_code/middleware/check_invite_middleware.dart';
import 'package:nestify/redux/settings/middleware/contact_support_middleware.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

final _serviceLocator = GetIt.instance;

List<Middleware<AppState>> appMiddleware = [
  /// Middlewares
  LoggerMiddleware(),
  NavigationMiddleware(_serviceLocator.get()),
  LoginWithGoogleMiddleware(_serviceLocator.get()),
  LogoutMiddleware(_serviceLocator.get()),
  CreateHomePickHomeAvatarMiddleware(_serviceLocator.get()),
  CreateHomeMiddleware(_serviceLocator.get()),
  CreateHomePickUserAvatarMiddleware(_serviceLocator.get()),
  LoadAvailableColorsMiddleware(_serviceLocator.get()),
  ContactSupportMiddleware(_serviceLocator.get(), _serviceLocator.get()),
  InitHomeMiddleware(_serviceLocator.get(), _serviceLocator.get()),
  ObtainInviteUrlMiddleware(_serviceLocator.get()),
  ShareInviteMiddleware(_serviceLocator.get()),
  InitJoinHomeMiddleware(_serviceLocator.get()),
  JoinHomePickUserAvatarMiddleware(
    _serviceLocator.get(),
    _serviceLocator.get(),
  ),
  JoinHomeMiddleware(
    _serviceLocator.get(),
    _serviceLocator.get(),
  ),
  CheckInviteMiddleware(_serviceLocator.get(), _serviceLocator.get()),
  DeleteHomeMiddleware(_serviceLocator.get(), _serviceLocator.get()),

  ///Epics
  EpicMiddleware<AppState>(DynamicLinksEpic(
    _serviceLocator.get(),
    _serviceLocator.get(),
    _serviceLocator.get(),
    _serviceLocator.get(),
  )),
];
