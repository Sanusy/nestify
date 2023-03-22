import 'package:freezed_annotation/freezed_annotation.dart';

part 'homeless_user_state.freezed.dart';

@freezed
abstract class HomelessUserState with _$HomelessUserState {
  const factory HomelessUserState({
    required bool isLoading,
    required HomelessUserError? error,
  }) = _HomelessUserState;

  factory HomelessUserState.initial() => const HomelessUserState(
        isLoading: false,
        error: null,
      );
}

@freezed
abstract class HomelessUserError with _$HomelessUserError {
  const factory HomelessUserError.failedToCreateHomeDraft() =
      _HomelessUserError;
}
