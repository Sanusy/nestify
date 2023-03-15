import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/base_middleware.dart';
import 'package:nestify/redux/login/login_action.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/service/user_service/user_service.dart';
import 'package:redux/redux.dart';

class LogoutMiddleware extends BaseMiddleware<LogoutAction> {
  final UserService _userService;

  LogoutMiddleware(
    this._userService,
  );

  @override
  Future<void> process(
    Store<AppState> store,
    LogoutAction action,
  ) async {
    await _userService.logOut();
    store.dispatch(const NavigationAction.setPath(AppRoute.login()));
  }
}
