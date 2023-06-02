import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nestify/models/home.dart';
import 'package:nestify/models/user.dart';
import 'package:nestify/models/user_color.dart';
import 'package:nestify/redux/app_reducer.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/join_home/join_home_action.dart';
import 'package:nestify/redux/join_home/join_home_state.dart';
import 'package:redux/redux.dart';

void main() {
  group('Join home reducers test', () {
    late Store<AppState> store;

    const homeToJoin = Home(
      id: 'id',
      homeName: 'homeName',
      adminId: 'adminId',
      usersIds: ['usersIds'],
      address: 'address',
      about: 'about',
      avatarUrl: 'avatarUrl',
    );

    const selectedColor = UserColor(
      id: 'id',
      ru: 'ru',
      en: 'en',
      hex: 'hex',
    );

    final colorsList = [
      const UserColor(
        id: 'id 2',
        ru: 'ru',
        en: 'en',
        hex: 'hex',
      ),
    ];
    final homeUsers = [
      const User(
        id: 'userId',
        userName: 'userName',
        homeId: 'homeId',
        colorId: 'colorId',
        bio: 'bio',
        avatarUrl: 'avatarUrl',
      ),
    ];

    setUp(() {
      store = Store<AppState>(
        appReducer,
        initialState: AppState.initial(),
      );
    });

    test('''on initialize join home loading is set
         to true and error is reset to null''', () {
      store.dispatch(InitJoinHomeAction(homeToJoin: homeToJoin));

      expect(
        store.state.joinHomeState.isLoading,
        true,
      );
      expect(store.state.homeState.error, null);
    });

    test('''on initialize join home failed 
      loading is set to false and set correct error''', () {
      store.dispatch(FailedToInitJoinHomeAction());

      expect(
        store.state.joinHomeState.isLoading,
        false,
      );
      expect(
        store.state.joinHomeState.error,
        const JoinHomeError.failedToInitJoinHome(),
      );
    });

    test('''on initialize join home success 
      loading is set to false and error is null and all loaded data set correctly''',
        () {
      ///Set error and loading values to ensure that reducer resets them
      store = Store<AppState>(
        appReducer,
        initialState: AppState.initial().copyWith(
          joinHomeState: store.state.joinHomeState.copyWith(
            error: const JoinHomeError.failedToInitJoinHome(),
            isLoading: true,
          ),
        ),
      );

      store.dispatch(JoinHomeInitializedAction(
        colors: colorsList,
        users: homeUsers,
      ));

      expect(
        store.state.joinHomeState.isLoading,
        false,
      );
      expect(store.state.joinHomeState.error, null);
      expect(
        store.state.joinHomeState.homeUsers,
        homeUsers,
      );
      expect(store.state.joinHomeState.colors, colorsList);
    });

    test('''on change step action step changed''', () {
      expect(store.state.joinHomeState.joinHomeStep, JoinHomeStep.homeInfo);

      store.dispatch(JoinHomeChangeStepAction(JoinHomeStep.userProfile));

      expect(store.state.joinHomeState.joinHomeStep, JoinHomeStep.userProfile);
    });

    test('''on user avatar picked set it in state''', () {
      final userAvatar = File('user avatar file path');

      store.dispatch(JoinHomeUserAvatarPickedAction(userAvatar));

      expect(
        store.state.joinHomeState.userProfileDraftState.userAvatar,
        userAvatar,
      );
    });

    test('''on user avatar removed reset it in state to null''', () {
      store.dispatch(JoinHomeRemoveUserAvatarAction());

      expect(
        store.state.joinHomeState.userProfileDraftState.userAvatar,
        isNull,
      );
    });

    test('''on user enter name, it changes in state''', () {
      const newUserName = ' new name';
      store.dispatch(JoinHomeUserNameChangedAction(newUserName));

      expect(
        store.state.joinHomeState.userProfileDraftState.userName,
        newUserName,
      );
    });

    test('''on user enter bio, it changes in state''', () {
      const newUserBio = ' new bio';
      store.dispatch(JoinHomeUserBioChangedAction(newUserBio));

      expect(
        store.state.joinHomeState.userProfileDraftState.userBio,
        newUserBio,
      );
    });

    test('''on user select color, it changes in state''', () {
      store.dispatch(JoinHomeColorSelectedAction(selectedColor));

      expect(
        store.state.joinHomeState.userProfileDraftState.selectedColor,
        selectedColor,
      );
    });

    test('''on join home loading is true and error is null''', () {
      store.dispatch(JoinHomeAction());

      expect(store.state.joinHomeState.isJoinInProgress, true);
      expect(store.state.joinHomeState.error, null);
    });

    test('''when join failed reset loading state''', () {
      store.dispatch(FailedToJoinHomeAction());

      expect(
        store.state.joinHomeState.isJoinInProgress,
        isFalse,
      );
    });

    test('''reset state action actually resets it''', () {
      store.dispatch(ResetJoinHomeStateAction());

      expect(
        store.state.joinHomeState,
        JoinHomeState.initial(),
      );
    });

    test('on make any change, has changes is true, on removing changes false',
        () {
      store.dispatch(JoinHomeUserNameChangedAction('newName'));

      expect(store.state.joinHomeState.hasChanges, true);

      store.dispatch(JoinHomeUserNameChangedAction(''));

      expect(store.state.joinHomeState.hasChanges, false);
    });

    test(
        'on make all needed changes, can add is true, on removing changes false',
        () {
      store.dispatch(JoinHomeUserNameChangedAction('newUserName'));
      store.dispatch(
        JoinHomeColorSelectedAction(selectedColor),
      );

      expect(store.state.joinHomeState.canJoinHome, true);

      store.dispatch(JoinHomeUserNameChangedAction(''));

      expect(store.state.joinHomeState.canJoinHome, false);
    });
  });
}
