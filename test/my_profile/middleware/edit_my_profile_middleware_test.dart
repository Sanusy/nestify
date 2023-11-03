import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nestify/models/nestify_user.dart';
import 'package:nestify/redux/app_reducer.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/my_profile/middleware/edit_my_profile_middleware.dart';
import 'package:nestify/redux/my_profile/my_profile_action.dart';
import 'package:nestify/redux/my_profile/my_profile_state.dart';
import 'package:nestify/service/file_error.dart';
import 'package:nestify/service/file_service/file_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:nestify/service/snack_bar_service/snack_bar_service.dart';
import 'package:nestify/service/user_service/user_service.dart';

import '../../test_store.dart';

class MockUserService extends Mock implements UserService {}

class MockFileService extends Mock implements FileService {}

class MockSnackBarService extends Mock implements SnackBarService {}

void main() {
  group(
    'Edit my profile middleware tests',
    () {
      late TestStore<AppState> store;

      late UserService mockUserService;
      late FileService mockFileService;
      late SnackBarService mockSnackBarService;

      late EditMyProfileMiddleware middleware;

      late NestifyUser initialUser;
      late NestifyUser userToEdit;
      late NestifyUser editedUser;

      const oldAvatarUrl = 'old avatar url';
      final newAvatar = File('');
      initialUser = const NestifyUser(
        id: 'user id 1',
        userName: 'user name',
        bio: 'bio',
        avatarUrl: oldAvatarUrl,
        homeId: 'home id',
        colorId: 'colorId',
      );
      userToEdit = const NestifyUser(
        id: 'user id 1',
        userName: 'user name',
        bio: 'bio',
        avatarUrl: oldAvatarUrl,
        homeId: 'home id',
        colorId: 'colorId',
      );

      editedUser = const NestifyUser(
        id: 'user id 1',
        userName: 'user name',
        bio: 'bio',
        avatarUrl: 'new avatar url',
        homeId: 'home id',
        colorId: 'colorId',
      );

      setUp(() {
        mockUserService = MockUserService();
        mockFileService = MockFileService();
        mockSnackBarService = MockSnackBarService();

        middleware = EditMyProfileMiddleware(
          mockUserService,
          mockFileService,
          mockSnackBarService,
        );
      });

      test('''on profile to edit null nothing happens''', () async {
        store = TestStore<AppState>(
          appReducer,
          initialState: AppState.initial(),
          middleware: [middleware],
        );
        await middleware.process(store, EditMyProfileAction());

        verifyZeroInteractions(mockUserService);
        verifyZeroInteractions(mockSnackBarService);
        verifyZeroInteractions(mockFileService);
        expect(store.actionLog.length, 0);
      });

      test('''on failed to upload avatar user sees error''', () async {
        store = TestStore<AppState>(
          appReducer,
          initialState: AppState.initial().copyWith(
              myProfileState: MyProfileState.initial().copyWith(
            pickedAvatar: newAvatar,
            editedProfile: userToEdit,
          )),
          middleware: [middleware],
        );

        when(() => mockUserService.editMyProfile(
            updatedProfile: userToEdit,
            newAvatar: newAvatar)).thenThrow(const FileError.failedToUpload());

        await middleware.process(store, EditMyProfileAction());

        verify(() => mockUserService.editMyProfile(
              updatedProfile: userToEdit,
              newAvatar: newAvatar,
            )).called(1);
        verify(() => mockSnackBarService.showCommonError()).called(1);
        expect(store.actionLog[0],
            const TypeMatcher<FailedToEditMyProfileAction>());
        expect(store.actionLog.length, 1);
      });

      test('''on failed to update profile in db user sees error''', () async {
        store = TestStore<AppState>(
          appReducer,
          initialState: AppState.initial().copyWith(
              myProfileState: MyProfileState.initial().copyWith(
            editedProfile: userToEdit,
          )),
          middleware: [middleware],
        );

        when(() => mockUserService.editMyProfile(
              updatedProfile: userToEdit,
            )).thenThrow(const NetworkError.unknown());

        await middleware.process(store, EditMyProfileAction());

        verify(() => mockUserService.editMyProfile(
              updatedProfile: userToEdit,
            )).called(1);
        verify(() => mockSnackBarService.showCommonError()).called(1);
        expect(store.actionLog[0],
            const TypeMatcher<FailedToEditMyProfileAction>());
        expect(store.actionLog.length, 1);
      });

      test('''on successful profile update app 
          notified''', () async {
        editedUser = userToEdit.copyWith(avatarUrl: 'some avatar url');

        store = TestStore<AppState>(
          appReducer,
          initialState: AppState.initial().copyWith(
              myProfileState: MyProfileState.initial().copyWith(
            editedProfile: userToEdit,
            pickedAvatar: newAvatar,
          )),
          middleware: [middleware],
        );

        when(() => mockUserService.editMyProfile(
              updatedProfile: userToEdit,
              newAvatar: newAvatar,
            )).thenAnswer((_) => Future.value(editedUser));

        await middleware.process(store, EditMyProfileAction());

        verify(() => mockUserService.editMyProfile(
              updatedProfile: userToEdit,
              newAvatar: newAvatar,
            )).called(1);
        verifyZeroInteractions(mockFileService);
        verifyZeroInteractions(mockSnackBarService);
        expect(store.actionLog[0], const TypeMatcher<MyProfileEditedAction>());
        expect(store.actionLog[0].editedUser, equals(editedUser));
        expect(store.actionLog.length, 1);
      });

      test('''check delete old avatar performed''', () async {
        store = TestStore<AppState>(
          appReducer,
          initialState: AppState.initial().copyWith(
              myProfileState: MyProfileState.initial().copyWith(
                  pickedAvatar: newAvatar,
                  editedProfile: userToEdit,
                  initialProfile: initialUser)),
          middleware: [middleware],
        );

        when(() => mockUserService.editMyProfile(
            updatedProfile: userToEdit,
            newAvatar: newAvatar)).thenAnswer((_) => Future.value(editedUser));
        when(() => mockFileService.removePicture(oldAvatarUrl))
            .thenAnswer((_) => Future.value());

        await middleware.process(store, EditMyProfileAction());

        verify(() => mockUserService.editMyProfile(
              updatedProfile: userToEdit,
              newAvatar: newAvatar,
            )).called(1);
        verify(() => mockFileService.removePicture(oldAvatarUrl)).called(1);
      });
    },
  );
}
