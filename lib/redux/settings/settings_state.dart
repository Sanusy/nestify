import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    required SettingsLoading? loading,
    required SettingsError? error,
  }) = _SettingsState;

  factory SettingsState.initial() => const SettingsState(
        loading: null,
        error: null,
      );
}

@freezed
class SettingsError with _$SettingsError {
  const factory SettingsError.failedToContactSupport() =
      _FailedToContactSupport;
}

enum SettingsLoading {
  contactSupport,
}
