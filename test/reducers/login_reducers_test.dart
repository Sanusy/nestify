import 'package:flutter_test/flutter_test.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/login/login_action.dart';
import 'package:nestify/redux/reducer.dart';
import 'package:redux/redux.dart';

void main() {
  group('Login reducers test group', () {
    test('login actions set login to true and error to false', () {
      final store =
          Store<AppState>(appReducer, initialState: AppState.initial());

      store.dispatch(LoginWithGoogleAction());

      expect(store.state.loginState.isGoogleLoginInProgress, true);
      expect(store.state.loginState.isFailed, false);
    });

    test('login with google sets error', () {
      final store =
          Store<AppState>(appReducer, initialState: AppState.initial());

      store.dispatch(FailedToLoginAction());

      expect(store.state.loginState.isGoogleLoginInProgress, false);
      expect(store.state.loginState.isFailed, true);
    });

    test('login success reset state', () {
      final store =
          Store<AppState>(appReducer, initialState: AppState.initial());

      store.dispatch(LoginSuccessAction());

      expect(store.state.loginState.isGoogleLoginInProgress, false);
      expect(store.state.loginState.isFailed, false);
    });
  });
}
