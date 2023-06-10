import 'package:flutter_test/flutter_test.dart';
import 'package:nestify/redux/app_reducer.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/home_profile/home_profile_action.dart';
import 'package:nestify/redux/home_profile/home_profile_state.dart';
import 'package:redux/redux.dart';

void main() {
  group('Home profile reducers test group', () {
    late Store<AppState> store;

    setUp(() {
      store = Store<AppState>(appReducer, initialState: AppState.initial());
    });

    test('on home deletion loading is true', () {
      store.dispatch(DeleteHomeAction());

      expect(
        store.state.homeProfileState.isLoading,
        isTrue,
      );
    });

    test('on home deletion failed loading is false', () {
      store.dispatch(FailedToDeleteHomeAction());

      expect(
        store.state.homeProfileState.isLoading,
        isFalse,
      );
    });

    test('after home deleted state resets to initial', () {
      store.dispatch(HomeDeletedAction());

      expect(
        store.state.homeProfileState,
        HomeProfileState.initial(),
      );
    });
  });
}
