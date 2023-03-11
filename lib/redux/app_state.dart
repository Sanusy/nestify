import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/redux/login/login_state.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    required LoginState loginState,
  }) = _AppState;

  factory AppState.initial() => AppState(
        loginState: LoginState.initial(),
      );
}
