import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/login/login_reducer.dart';

AppState appReducer(AppState state, dynamic action) => state.copyWith(
      loginState: loginStateReducer(state.loginState, action),
    );
