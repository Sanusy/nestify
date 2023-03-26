import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/create_home/create_home_action.dart';
import 'package:nestify/redux/create_home/create_home_state.dart';
import 'package:nestify/redux/reducer.dart';
import 'package:redux/redux.dart';

void main() {
  group('Create home reducers test group', () {
    test('when home name changed action, correctly change name in state', () {
      final store =
          Store<AppState>(appReducer, initialState: AppState.initial());

      const newHomeName = 'New home name';

      store.dispatch(HomeNameChangedAction(newHomeName));

      expect(store.state.createHomeState.homeName, newHomeName);
    });

    test('when home address changed action, correctly change address in state',
        () {
      final store =
          Store<AppState>(appReducer, initialState: AppState.initial());

      const newHomeAddress = 'New home address';

      store.dispatch(HomeAddressChangedAction(newHomeAddress));

      expect(store.state.createHomeState.homeAddress, newHomeAddress);
    });

    test('when home about changed action, correctly change about in state', () {
      final store =
          Store<AppState>(appReducer, initialState: AppState.initial());

      const newAbout = 'New home about';

      store.dispatch(HomeAboutChangedAction(newAbout));

      expect(store.state.createHomeState.about, newAbout);
    });

    test('when avatar picked, set it', () {
      final store =
          Store<AppState>(appReducer, initialState: AppState.initial());

      final avatar = File('avatarPath');

      expect(store.state.createHomeState.avatar, null);

      store.dispatch(CreateHomeAvatarPickedAction(avatar));

      expect(store.state.createHomeState.avatar, avatar);
    });

    test('when remove avatar clicked, remove avatar', () {
      final store = Store<AppState>(
        appReducer,
        initialState: AppState.initial().copyWith(
          createHomeState: CreateHomeState.initial().copyWith(
            avatar: File('some avatar file'),
          ),
        ),
      );

      expect(store.state.createHomeState.avatar, isNotNull);

      store.dispatch(RemoveCreateHomeAvatarAction());

      expect(store.state.createHomeState.avatar, null);
    });

    test('when failed to pick avatar, set error', () {
      final store =
          Store<AppState>(appReducer, initialState: AppState.initial());

      store.dispatch(FailedToPickCreateHomeAvatarAction());

      expect(
        store.state.createHomeState.error,
        const CreateHomeError.failedToObtainPhoto(),
      );
    });

    test('when create home clicked, show loading while adding home', () {
      final store =
          Store<AppState>(appReducer, initialState: AppState.initial());

      store.dispatch(CreateHomeAction());

      expect(store.state.createHomeState.isLoading, true);
    });

    test('when created reset state to initial', () {
      final store =
          Store<AppState>(appReducer, initialState: AppState.initial());

      store.dispatch(HomeCreatedAction());

      expect(store.state.createHomeState, CreateHomeState.initial());
    });

    test('when failed to create home, set correct error', () {
      final store =
          Store<AppState>(appReducer, initialState: AppState.initial());

      store.dispatch(FailedToCreateHomeAction());

      expect(
        store.state.createHomeState.error,
        const CreateHomeError.failedToCreate(),
      );
    });

    test('when error processed error state is null', () {
      final store =
          Store<AppState>(appReducer, initialState: AppState.initial());

      store.dispatch(CreateHomeErrorProcessedAction());

      expect(store.state.createHomeState.error, 'null');
    });
  });
}
