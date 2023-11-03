import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nestify/models/nestify_user.dart';
import 'package:nestify/models/user_color.dart';
import 'package:nestify/redux/app_reducer.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/my_profile/my_profile_action.dart';
import 'package:nestify/redux/my_profile/my_profile_state.dart';
import 'package:redux/redux.dart';

void main() {
  group('My profile reducers test group', () {
    late Store<AppState> store;

    const initialUser = NestifyUser(
      id: 'user id 1',
      userName: 'user name',
      bio: 'bio',
      avatarUrl: 'avatar url',
      homeId: 'home id',
      colorId: 'colorId',
    );

    setUp(() {
      store = Store<AppState>(
        appReducer,
        initialState: AppState.initial().copyWith(
            myProfileState: MyProfileState.initial().copyWith(
          initialProfile: initialUser,
          editedProfile: initialUser,
        )),
      );
    });

    test('my profile initialized properly', () {
      store = Store<AppState>(
        appReducer,
        initialState: AppState.initial(),
      );

      store.dispatch(InitMyProfileAction(initialUser));

      expect(
        store.state.myProfileState.initialProfile,
        equals(initialUser),
      );
      expect(
        store.state.myProfileState.initialProfile,
        equals(initialUser),
      );
      expect(store.state.myProfileState.isLoading, false);
    });

    test('on close my profile state cleared', () {
      store.dispatch(CloseMyProfileAction());

      expect(
        store.state.myProfileState,
        equals(MyProfileState.initial()),
      );
    });

    test('set avatar after user pick', () {
      final pickedAvatar = File('');
      store.dispatch(MyProfileAvatarPickedAction(pickedAvatar));

      expect(
        store.state.myProfileState.pickedAvatar,
        pickedAvatar,
      );
    });

    test(
        'on remove avatar trigger new avatar file and old avatar url set to null',
        () {
      store.dispatch(RemoveMyProfileAvatarAction());

      expect(store.state.myProfileState.pickedAvatar, isNull);
      expect(store.state.myProfileState.editedProfile?.avatarUrl, isNull);
    });

    test(
        'on user name changed action, ONLY edited profile name in state changes',
        () {
      const newName = 'new user name';

      store.dispatch(MyProfileNameChangedAction(newName));

      expect(
          store.state.myProfileState.editedProfile?.userName, equals(newName));
      expect(store.state.myProfileState.initialProfile?.userName,
          equals(initialUser.userName));
    });

    test('on bio changed action, ONLY edited profile bio in state changes', () {
      const newBio = 'new bio';

      store.dispatch(MyProfileBioChangedAction(newBio));

      expect(store.state.myProfileState.editedProfile?.bio, equals(newBio));
      expect(store.state.myProfileState.initialProfile?.bio,
          equals(initialUser.bio));
    });

    test('on color changed action, ONLY edited profile color in state changes',
        () {
      const newColor = UserColor(
        id: 'new color id',
        ru: 'ru',
        en: 'en',
        hex: 'hex',
      );

      store.dispatch(MyProfileColorChangedAction(newColor));

      expect(store.state.myProfileState.editedProfile?.colorId,
          equals(newColor.id));
      expect(store.state.myProfileState.initialProfile?.colorId,
          equals(initialUser.colorId));
    });

    test('on edit my profile triggered set loading', () {
      store.dispatch(EditMyProfileAction());

      expect(store.state.myProfileState.isLoading, isTrue);
    });

    test('''on home edited reset loader, 
        set new initial and edited profiles, reset avatar''', () {
      final editedProfile = initialUser.copyWith(userName: 'new user name');

      store.dispatch(MyProfileEditedAction(editedProfile));

      expect(store.state.myProfileState.isLoading, isFalse);
      expect(store.state.myProfileState.pickedAvatar, isNull);
      expect(store.state.myProfileState.initialProfile, equals(editedProfile));
      expect(store.state.myProfileState.initialProfile, equals(editedProfile));
    });

    test('on profile edit failed reset loader', () {
      store.dispatch(FailedToEditMyProfileAction());

      expect(store.state.myProfileState.isLoading, isFalse);
    });

    test('on make any change, has changes is true, on removing changes false',
        () {
      store.dispatch(MyProfileNameChangedAction('new Name'));

      expect(store.state.myProfileState.hasChanges, isTrue);

      store.dispatch(MyProfileNameChangedAction(initialUser.userName));

      expect(store.state.myProfileState.hasChanges, isFalse);

      final avatar = File('');

      store.dispatch(MyProfileAvatarPickedAction(avatar));

      expect(store.state.myProfileState.hasChanges, isTrue);
    });

    test('on empty name can save profile is false', () {
      expect(store.state.myProfileState.canEditMyProfile, isTrue);

      store.dispatch(MyProfileNameChangedAction(''));

      expect(store.state.myProfileState.canEditMyProfile, isFalse);
    });
  });
}
