import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/redux/create_home/create_home_state.dart';
import 'package:nestify/redux/create_user_profile/create_user_profile_state.dart';
import 'package:nestify/redux/login/login_state.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    required LoginState loginState,
    required CreateHomeState createHomeState,
    required CreateUserProfileState createUserProfileState,
  }) = _AppState;

  factory AppState.initial() => AppState(
        loginState: LoginState.initial(),
        createHomeState: CreateHomeState.initial(),
        createUserProfileState: CreateUserProfileState.initial(),
      );
}
