import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/redux/settings/settings_state.dart';
import 'package:nestify/ui/command.dart';

part 'settings_view_model.freezed.dart';

@Freezed(copyWith: false)
class SettingsViewModel with _$SettingsViewModel {
  const factory SettingsViewModel({
    required Command? onOpenProfile,
    required Command? onContactSupport,
    required Command? onOpenPrivacyPolicy,
    required Command? onOpenTermsAndConditions,
    required Command? onLogout,
    required SettingsLoading? loading,
    required SettingsEvent? event,
  }) = _SettingsViewModel;
}

@Freezed(copyWith: false)
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.failedToContactSupport({
    required Command onProcessed,
  }) = _FailedToContactSupprot;
}
