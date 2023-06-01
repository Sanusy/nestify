import 'package:flutter_test/flutter_test.dart';
import 'package:nestify/redux/app_reducer.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/settings/settings_action.dart';
import 'package:nestify/redux/settings/settings_state.dart';
import 'package:redux/redux.dart';

void main() {
  group('Settings reducers test group', () {
    late Store<AppState> store;

    setUp(() {
      store = Store<AppState>(appReducer, initialState: AppState.initial());
    });

    test('contact support action sets loading to true', () {
      store.dispatch(ContactSupportAction());

      expect(store.state.settingsState.loading, SettingsLoading.contactSupport);
    });

    test('failed to contact support action sets correct loading', () {
      store.dispatch(FailedToContactSupportAction());

      expect(store.state.settingsState.loading, null);
      expect(
        store.state.settingsState.error,
        const SettingsError.failedToContactSupport(),
      );
    });

    test('contact support opened action sets loading state to null', () {
      store.dispatch(ContactSupportOpenedAction());

      expect(store.state.settingsState.loading, null);
    });

    test('process error action resets error to null', () {
      store.dispatch(SettingsErrorProcessedAction());

      expect(store.state.settingsState.error, null);
    });
  });
}
