import 'package:flutter_test/flutter_test.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/homeless_user/homeless_user_action.dart';
import 'package:nestify/redux/homeless_user/homeless_user_state.dart';
import 'package:nestify/redux/reducer.dart';
import 'package:redux/redux.dart';

void main() {
  group('Homeless user reducers test group', () {
    test(
        'on create home button click loading is true while creating home draft',
        () {
      final store =
          Store<AppState>(appReducer, initialState: AppState.initial());

      store.dispatch(CreateHomeDraftAction());

      expect(store.state.homelessUserState.isLoading, true);
      expect(store.state.homelessUserState.error, null);
    });

    test('when draft created login is false', () {
      final store =
          Store<AppState>(appReducer, initialState: AppState.initial());

      store.dispatch(CreatedHomeDraftAction());

      expect(store.state.homelessUserState.isLoading, false);
      expect(store.state.homelessUserState.error, null);
    });

    test('when failed to create home draft, correct error is set', () {
      final store =
          Store<AppState>(appReducer, initialState: AppState.initial());

      store.dispatch(FailedToOpenCreateHomeAction());

      expect(store.state.homelessUserState.isLoading, false);
      expect(
        store.state.homelessUserState.error,
        const HomelessUserError.failedToCreateHomeDraft(),
      );
    });

    test('when error processed error state is null', () {
      final store =
          Store<AppState>(appReducer, initialState: AppState.initial());

      store.dispatch(HomelessUserErrorProcessedAction());

      expect(store.state.homelessUserState.error, null);
    });
  });
}
