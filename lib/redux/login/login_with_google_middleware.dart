import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/base_middleware.dart';
import 'package:nestify/redux/login/login_action.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/service/network_error.dart';
import 'package:nestify/service/user_service/user_service.dart';
import 'package:redux/redux.dart';

class LoginWithGoogleMiddleware extends BaseMiddleware<LoginWithGoogleAction> {
  final UserService _userService;

  LoginWithGoogleMiddleware(
    this._userService,
  );

  @override
  Future<void> process(
    Store<AppState> store,
    LoginWithGoogleAction action,
  ) async {
    try {
      await _userService.logInWithGoogle();

      store.dispatch(LoginSuccessAction());
      store.dispatch(const NavigationAction.replace(AppRoute.rootTebBar()));
    } on NetworkError {
      store.dispatch(FailedToLoginAction());
    }
  }
}
