import 'package:nestify/redux/settings/settings_action.dart';
import 'package:nestify/redux/settings/settings_state.dart';
import 'package:redux/redux.dart';

final settingsStateReducer = combineReducers<SettingsState>([
  TypedReducer(_failedToContactSupport),
  TypedReducer(_contactSupport),
  TypedReducer(_contactSupportOpened),
  TypedReducer(_errorProcessed),
]);

SettingsState _failedToContactSupport(
  SettingsState state,
  FailedToContactSupportAction action,
) {
  return state.copyWith(
    loading: null,
    error: const SettingsError.failedToContactSupport(),
  );
}

SettingsState _contactSupport(
  SettingsState state,
  ContactSupportAction action,
) {
  return state.copyWith(
    loading: SettingsLoading.contactSupport,
  );
}

SettingsState _contactSupportOpened(
  SettingsState state,
  ContactSupportOpenedAction action,
) {
  return state.copyWith(
    loading: null,
  );
}

SettingsState _errorProcessed(
  SettingsState state,
  SettingsErrorProcessedAction action,
) {
  return state.copyWith(error: null);
}
