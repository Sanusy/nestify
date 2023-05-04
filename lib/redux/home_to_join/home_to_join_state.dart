import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_to_join_state.freezed.dart';

@freezed
class HomeToJoinState with _$HomeToJoinState {
  const factory HomeToJoinState({
    required bool isLoading,
    required HomeToJoinError? error,
  }) = _HomeToJoinState;

  factory HomeToJoinState.initial() => const HomeToJoinState(
        isLoading: false,
        error: null,
      );
}

@freezed
class HomeToJoinError with _$HomeToJoinError {
  const factory HomeToJoinError.failedToJoinHome() = _FailedToJoinHome;
}
