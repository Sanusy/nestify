import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/redux/add_member/add_member_state.dart';
import 'package:nestify/redux/create_home/create_home_state.dart';
import 'package:nestify/redux/home/home_state.dart';
import 'package:nestify/redux/login/login_state.dart';
import 'package:nestify/redux/settings/settings_state.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    required LoginState loginState,
    required CreateHomeState createHomeState,
    required SettingsState settingsState,
    required HomeState homeState,
    required AddMemberState addMemberState,
  }) = _AppState;

  factory AppState.initial() => AppState(
        loginState: LoginState.initial(),
        createHomeState: CreateHomeState.initial(),
        settingsState: SettingsState.initial(),
        homeState: HomeState.initial(),
        addMemberState: AddMemberState.initial(),
      );
}
