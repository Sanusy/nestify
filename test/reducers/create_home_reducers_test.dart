import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nestify/models/user_color.dart';
import 'package:nestify/redux/app_reducer.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/create_home/create_home_action.dart';
import 'package:nestify/redux/create_home/create_home_state.dart';
import 'package:redux/redux.dart';

void main() {
  group('Create home reducers test group', () {
    late Store<AppState> store;

    setUp(() {
      store = Store<AppState>(appReducer, initialState: AppState.initial());
    });

    test('load colors action sets colors state to loading', () {
      store.dispatch(LoadAvailableColorsAction());

      expect(
        store.state.createHomeState.colorsState,
        const ColorsLoadingState.loading(),
      );
      expect(store.state.createHomeState.isLoading, false);
    });

    test(
        'loaded colors action sets colors state to loaded with correct list of colors',
        () {
      final colorsList = [
        const UserColor(id: 'id', ru: 'ru', en: 'en', hex: 'hex'),
      ];

      store.dispatch(LoadedAvailableColorsAction(colorsList));

      expect(
        store.state.createHomeState.colorsState,
        ColorsLoadingState.loaded(availableColors: colorsList),
      );
      expect(store.state.createHomeState.isLoading, false);
    });

    test('failed to load colors action sets colors state to error', () {
      store.dispatch(FailedToLoadAvailableColorsAction());

      expect(
        store.state.createHomeState.colorsState,
        const ColorsLoadingState.error(),
      );
      expect(store.state.createHomeState.isLoading, false);
    });

    test('on step change action step changes in state', () {
      const goingFromStep = CreateHomeStep.homeProfile;
      const stepToGoTo = CreateHomeStep.userProfile;

      expect(store.state.createHomeState.createHomeStep, goingFromStep);
      store.dispatch(CreateHomeStepChangedAction(stepToGoTo));

      expect(store.state.createHomeState.createHomeStep, stepToGoTo);
      expect(store.state.createHomeState.isLoading, false);
    });

    test('on home name changed action, ONLY home name in state changes', () {
      const newName = 'new home name';
      final stateBeforeChange = store.state.createHomeState;

      store.dispatch(CreateHomeNameChangedAction(newName));

      expect(
        store.state.createHomeState.homeProfileDraftState,
        stateBeforeChange.homeProfileDraftState.copyWith(homeName: newName),
      );
      expect(
        store.state.createHomeState.userProfileDraftState,
        stateBeforeChange.userProfileDraftState,
      );
      expect(store.state.createHomeState.isLoading, false);
    });

    test('on home address changed action, ONLY home address in state changes',
        () {
      const newAddress = 'new home address';
      final stateBeforeChange = store.state.createHomeState;

      store.dispatch(CreateHomeAddressChangedAction(newAddress));

      expect(
        store.state.createHomeState.homeProfileDraftState,
        stateBeforeChange.homeProfileDraftState
            .copyWith(homeAddress: newAddress),
      );
      expect(
        store.state.createHomeState.userProfileDraftState,
        stateBeforeChange.userProfileDraftState,
      );
      expect(store.state.createHomeState.isLoading, false);
    });

    test('on home about changed action, ONLY home about in state changes', () {
      const newAbout = 'new home about';
      final stateBeforeChange = store.state.createHomeState;

      store.dispatch(CreateHomeAboutChangedAction(newAbout));

      expect(
        store.state.createHomeState.homeProfileDraftState,
        stateBeforeChange.homeProfileDraftState.copyWith(homeAbout: newAbout),
      );
      expect(
        store.state.createHomeState.userProfileDraftState,
        stateBeforeChange.userProfileDraftState,
      );
      expect(store.state.createHomeState.isLoading, false);
    });

    test('on pick home avatar action, ONLY home avatar in state changes', () {
      final avatar = File('path to avatar');
      final stateBeforeChange = store.state.createHomeState;

      store.dispatch(CreateHomeAvatarPickedAction(avatar));

      expect(
        store.state.createHomeState.homeProfileDraftState,
        stateBeforeChange.homeProfileDraftState.copyWith(homeAvatar: avatar),
      );
      expect(
        store.state.createHomeState.userProfileDraftState,
        stateBeforeChange.userProfileDraftState,
      );
      expect(store.state.createHomeState.isLoading, false);
    });

    test('on remove home avatar action, ONLY home avatar in state changes', () {
      final stateBeforeChange = store.state.createHomeState;

      store.dispatch(RemoveCreateHomeAvatarAction());

      expect(
        store.state.createHomeState.homeProfileDraftState,
        stateBeforeChange.homeProfileDraftState.copyWith(homeAvatar: null),
      );
      expect(
        store.state.createHomeState.userProfileDraftState,
        stateBeforeChange.userProfileDraftState,
      );
      expect(store.state.createHomeState.isLoading, false);
    });

    test('on user name changed action, ONLY user name in state changes', () {
      const newUserName = 'new user name';
      final stateBeforeChange = store.state.createHomeState;

      store.dispatch(CreateHomeUserNameChangedAction(newUserName));

      expect(store.state.createHomeState.userProfileDraftState.userName,
          newUserName);
      expect(
        store.state.createHomeState.homeProfileDraftState,
        stateBeforeChange.homeProfileDraftState,
      );
      expect(
        store.state.createHomeState.userProfileDraftState,
        stateBeforeChange.userProfileDraftState.copyWith(userName: newUserName),
      );
      expect(store.state.createHomeState.isLoading, false);
    });

    test('on user bio changed action, ONLY user bio in state changes', () {
      const newUserBio = 'new user bio';
      final stateBeforeChange = store.state.createHomeState;

      store.dispatch(CreateHomeUserBioChangedAction(newUserBio));

      expect(
        store.state.createHomeState.homeProfileDraftState,
        stateBeforeChange.homeProfileDraftState,
      );
      expect(
        store.state.createHomeState.userProfileDraftState,
        stateBeforeChange.userProfileDraftState.copyWith(userBio: newUserBio),
      );
      expect(store.state.createHomeState.isLoading, false);
    });

    test('on pick user avatar action, ONLY user avatar in state changes', () {
      final avatar = File('path to avatar');
      final stateBeforeChange = store.state.createHomeState;

      store.dispatch(CreateHomeUserAvatarPickedAction(avatar));

      expect(
        store.state.createHomeState.homeProfileDraftState,
        stateBeforeChange.homeProfileDraftState,
      );
      expect(
        store.state.createHomeState.userProfileDraftState,
        stateBeforeChange.userProfileDraftState.copyWith(userAvatar: avatar),
      );
      expect(store.state.createHomeState.isLoading, false);
    });

    test('on remove user avatar action, ONLY user avatar in state changes', () {
      final stateBeforeChange = store.state.createHomeState;

      store.dispatch(CreateHomeRemoveUserAvatarAction());

      expect(
        store.state.createHomeState.homeProfileDraftState,
        stateBeforeChange.homeProfileDraftState,
      );
      expect(
        store.state.createHomeState.userProfileDraftState,
        stateBeforeChange.userProfileDraftState.copyWith(userAvatar: null),
      );
      expect(store.state.createHomeState.isLoading, false);
    });

    test(
        'on failed to pick any avatar action, ONLY correct error in state appears',
        () {
      final stateBeforeChange = store.state.createHomeState;

      store.dispatch(CreateHomeFailedToPickAvatarAction());

      expect(
        store.state.createHomeState.homeProfileDraftState,
        stateBeforeChange.homeProfileDraftState,
      );
      expect(
        store.state.createHomeState.userProfileDraftState,
        stateBeforeChange.userProfileDraftState,
      );
      expect(
        store.state.createHomeState.error,
        const CreateHomeError.failedToObtainPhoto(),
      );
      expect(store.state.createHomeState.isLoading, false);
    });

    test('on select color action, ONLY color changes in state appears', () {
      final stateBeforeChange = store.state.createHomeState;
      const selectedColor =
          UserColor(id: 'colorId', ru: 'ru', en: 'en', hex: 'hex');

      store.dispatch(CreateHomeColorSelectedAction(selectedColor));

      expect(
        store.state.createHomeState.homeProfileDraftState,
        stateBeforeChange.homeProfileDraftState,
      );
      expect(
        store.state.createHomeState.userProfileDraftState,
        stateBeforeChange.userProfileDraftState
            .copyWith(selectedColor: selectedColor),
      );
      expect(store.state.createHomeState.isLoading, false);
    });

    test('on create home, loading sets to true', () {
      store.dispatch(CreateHomeAction());
      expect(store.state.createHomeState.isLoading, true);
    });

    test('on failed to create home, loading sets to false and correct error',
        () {
      store.dispatch(FailedToCreateHomeAction());

      expect(store.state.createHomeState.isLoading, false);
      expect(store.state.createHomeState.error,
          const CreateHomeError.failedToCreate());
    });

    test('on error processed, error is reset to null', () {
      store.dispatch(CreateHomeErrorProcessedAction());

      expect(store.state.createHomeState.error, null);
    });

    test('on close create home, state set to initial', () {
      store.dispatch(CloseCreateHomeAction());

      expect(store.state.createHomeState, CreateHomeState.initial());
    });

    test('on make any change, has changes is true, on removing changes false',
        () {
      store.dispatch(CreateHomeNameChangedAction('newName'));

      expect(store.state.createHomeState.hasChanges, true);

      store.dispatch(CreateHomeNameChangedAction(''));

      expect(store.state.createHomeState.hasChanges, false);
    });

    test(
        'on make all needed changes, can add is true, on removing changes false',
        () {
      store.dispatch(CreateHomeNameChangedAction('newName'));
      store.dispatch(CreateHomeUserNameChangedAction('newUserName'));
      store.dispatch(
        CreateHomeColorSelectedAction(const UserColor(
          id: 'id',
          ru: 'ru',
          en: 'en',
          hex: 'hex',
        )),
      );

      expect(store.state.createHomeState.canCreateHome, true);

      store.dispatch(CreateHomeNameChangedAction(''));

      expect(store.state.createHomeState.canCreateHome, false);
    });
  });
}
