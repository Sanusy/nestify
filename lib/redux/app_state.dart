import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/redux/create_home/create_home_state.dart';
import 'package:nestify/redux/homeless_user/homeless_user_state.dart';
import 'package:nestify/redux/login/login_state.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    required LoginState loginState,
    required HomelessUserState homelessUserState,
    required CreateHomeState createHomeState,
  }) = _AppState;

  factory AppState.initial() => AppState(
        loginState: LoginState.initial(),
        homelessUserState: HomelessUserState.initial(),
        createHomeState: CreateHomeState.initial(),
      );
}
