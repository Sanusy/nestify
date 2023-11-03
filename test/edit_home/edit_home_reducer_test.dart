import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nestify/models/home.dart';
import 'package:nestify/redux/app_reducer.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/edit_home/edit_home_action.dart';
import 'package:nestify/redux/edit_home/edit_home_state.dart';
import 'package:redux/redux.dart';

void main() {
  group('Edit home reducers test group', () {
    late Store<AppState> store;

    const initialHome = Home(
      id: 'home id 1',
      homeName: 'home name',
      adminId: 'adminId',
      usersIds: [],
      address: 'address',
      about: 'about',
      avatarUrl: 'avatar url',
    );

    setUp(() {
      store = Store<AppState>(
        appReducer,
        initialState: AppState.initial().copyWith(
            editHomeState: EditHomeState.initial().copyWith(
          initialHome: initialHome,
          editedHome: initialHome,
        )),
      );
    });

    test('edit home initialized properly', () {
      store = Store<AppState>(
        appReducer,
        initialState: AppState.initial(),
      );

      store.dispatch(InitEditHomeAction(initialHome));

      expect(
        store.state.editHomeState.initialHome,
        equals(initialHome),
      );
      expect(
        store.state.editHomeState.editedHome,
        equals(initialHome),
      );
      expect(store.state.editHomeState.isLoading, false);
    });

    test('on close edit home state cleared', () {
      store.dispatch(CloseEditHomeAction());

      expect(
        store.state.editHomeState,
        equals(EditHomeState.initial()),
      );
    });

    test('set avatar after user pick', () {
      final pickedAvatar = File('');
      store.dispatch(EditHomeAvatarPickedAction(pickedAvatar));

      expect(
        store.state.editHomeState.pickedAvatar,
        pickedAvatar,
      );
    });

    test(
        'on remove avatar trigger new avatar file and old avatar url set to null',
        () {
      store.dispatch(RemoveEditHomeAvatarAction());

      expect(store.state.editHomeState.pickedAvatar, isNull);
      expect(store.state.editHomeState.editedHome?.avatarUrl, isNull);
    });

    test('on home name changed action, ONLY edited home name in state changes',
        () {
      const newName = 'new home name';

      store.dispatch(EditHomeNameChangedAction(newName));

      expect(store.state.editHomeState.editedHome?.homeName, equals(newName));
      expect(store.state.editHomeState.initialHome?.homeName,
          equals(initialHome.homeName));
    });

    test(
        'on home address changed action, ONLY edited home address in state changes',
        () {
      const newAddress = 'new home address';

      store.dispatch(EditHomeAddressChangedAction(newAddress));

      expect(store.state.editHomeState.editedHome?.address, equals(newAddress));
      expect(store.state.editHomeState.initialHome?.address,
          equals(initialHome.address));
    });

    test(
        'on home about changed action, ONLY edited home about in state changes',
        () {
      const newAbout = 'new home about';

      store.dispatch(EditHomeAboutChangedAction(newAbout));

      expect(store.state.editHomeState.editedHome?.about, equals(newAbout));
      expect(store.state.editHomeState.initialHome?.about,
          equals(initialHome.about));
    });

    test('on edit home triggered set loading', () {
      store.dispatch(EditHomeAction());

      expect(store.state.editHomeState.isLoading, isTrue);
    });

    test('on home edited reset loader', () {
      store.dispatch(
          HomeEditedAction(initialHome.copyWith(homeName: 'new home name')));

      expect(store.state.editHomeState.isLoading, isFalse);
    });

    test('on home edit failed reset loader', () {
      store.dispatch(FailedToEditHomeAction());

      expect(store.state.editHomeState.isLoading, isFalse);
    });

    test('on make any change, has changes is true, on removing changes false',
        () {
      store.dispatch(EditHomeNameChangedAction('new Name'));

      expect(store.state.editHomeState.hasChanges, isTrue);

      store.dispatch(EditHomeNameChangedAction(initialHome.homeName));

      expect(store.state.editHomeState.hasChanges, isFalse);

      final avatar = File('');

      store.dispatch(EditHomeAvatarPickedAction(avatar));

      expect(store.state.editHomeState.hasChanges, isTrue);
    });

    test('on empty name can save home is false', () {
      expect(store.state.editHomeState.canEditHome, isTrue);

      store.dispatch(EditHomeNameChangedAction(''));

      expect(store.state.editHomeState.canEditHome, isFalse);
    });
  });
}
