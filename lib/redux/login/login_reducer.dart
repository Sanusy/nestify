import 'package:nestify/redux/login/login_action.dart';
import 'package:nestify/redux/login/login_state.dart';
import 'package:redux/redux.dart';

final loginStateReducer = combineReducers<LoginState>([
  TypedReducer(_loginWithGoogle),
  TypedReducer(_loginSuccess),
  TypedReducer(_failedToLogin),
]);

LoginState _loginWithGoogle(LoginState state, LoginWithGoogleAction action) {
  return state.copyWith(
    isFailed: false,
    isGoogleLoginInProgress: true,
  );
}

LoginState _loginSuccess(LoginState state, LoginSuccessAction action) {
  return state.copyWith(
    isFailed: false,
    isGoogleLoginInProgress: false,
  );
}

LoginState _failedToLogin(LoginState state, FailedToLoginAction action) {
  return state.copyWith(
    isFailed: true,
    isGoogleLoginInProgress: false,
  );
}
