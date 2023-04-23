import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/create_home/create_home_reducer.dart';
import 'package:nestify/redux/home/home_reducer.dart';
import 'package:nestify/redux/login/login_reducer.dart';
import 'package:nestify/redux/settings/settings_reducer.dart';

AppState appReducer(AppState state, dynamic action) => state.copyWith(
      loginState: loginStateReducer(state.loginState, action),
      createHomeState: createHomeStateReducer(state.createHomeState, action),
      settingsState: settingsStateReducer(state.settingsState, action),
      homeState: homeStateReducer(state.homeState, action),
    );
