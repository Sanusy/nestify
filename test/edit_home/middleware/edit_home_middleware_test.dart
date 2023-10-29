import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nestify/models/home.dart';
import 'package:nestify/redux/app_reducer.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/edit_home/edit_home_action.dart';
import 'package:nestify/redux/edit_home/edit_home_state.dart';
import 'package:nestify/redux/edit_home/middleware/edit_home_middleware.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/service/file_error.dart';
import 'package:nestify/service/file_service/file_service.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:nestify/service/snack_bar_service/snack_bar_service.dart';

import '../../test_store.dart';

class MockHomeService extends Mock implements HomeService {}

class MockFileService extends Mock implements FileService {}

class MockSnackBarService extends Mock implements SnackBarService {}

void main() {
  group(
    'Edit home middleware tests',
    () {
      late TestStore<AppState> store;

      late HomeService mockHomeService;
      late FileService mockFileService;
      late SnackBarService mockSnackBarService;

      late EditHomeMiddleware middleware;

      late Home initialHome;
      late Home homeToEdit;
      late Home editedHome;

      const oldAvatarUrl = 'old avatar url';
      final newAvatar = File('');
      initialHome = const Home(
        id: 'home id 1',
        homeName: 'home name',
        adminId: 'adminId',
        usersIds: [],
        address: 'address',
        about: 'about',
        avatarUrl: oldAvatarUrl,
      );
      homeToEdit = const Home(
        id: 'home id 2',
        homeName: 'new home name',
        adminId: 'adminId',
        usersIds: [],
        address: 'address',
        about: 'about',
        avatarUrl: oldAvatarUrl,
      );

      editedHome = const Home(
        id: 'home id 2',
        homeName: 'new home name',
        adminId: 'adminId',
        usersIds: [],
        address: 'address',
        about: 'about',
        avatarUrl: 'new avatar url',
      );

      setUp(() {
        mockHomeService = MockHomeService();
        mockFileService = MockFileService();
        mockSnackBarService = MockSnackBarService();

        middleware = EditHomeMiddleware(
          mockHomeService,
          mockFileService,
          mockSnackBarService,
        );
      });

      test('''on home to edit null nothing happens''', () async {
        store = TestStore<AppState>(
          appReducer,
          initialState: AppState.initial(),
          middleware: [middleware],
        );
        await middleware.process(store, EditHomeAction());

        verifyZeroInteractions(mockHomeService);
        verifyZeroInteractions(mockSnackBarService);
        verifyZeroInteractions(mockFileService);
        expect(store.actionLog.length, 0);
      });

      test('''on failed to upload avatar user sees error''', () async {

        store = TestStore<AppState>(
          appReducer,
          initialState: AppState.initial().copyWith(
              editHomeState: EditHomeState.initial().copyWith(
            pickedAvatar: newAvatar,
            editedHome: homeToEdit,
          )),
          middleware: [middleware],
        );

        when(() => mockHomeService.editHome(
            homeToEdit: homeToEdit,
            newAvatar: newAvatar)).thenThrow(const FileError.failedToUpload());

        await middleware.process(store, EditHomeAction());

        verify(() => mockHomeService.editHome(
              homeToEdit: homeToEdit,
              newAvatar: newAvatar,
            )).called(1);
        verify(() => mockSnackBarService.showCommonError()).called(1);
        expect(store.actionLog[0], const TypeMatcher<FailedToEditHomeAction>());
        expect(store.actionLog.length, 1);
      });

      test('''on failed to update home in db user sees error''', () async {
        store = TestStore<AppState>(
          appReducer,
          initialState: AppState.initial().copyWith(
              editHomeState: EditHomeState.initial().copyWith(
            editedHome: homeToEdit,
          )),
          middleware: [middleware],
        );

        when(() => mockHomeService.editHome(
              homeToEdit: homeToEdit,
            )).thenThrow(const NetworkError.unknown());

        await middleware.process(store, EditHomeAction());

        verify(() => mockHomeService.editHome(
              homeToEdit: homeToEdit,
            )).called(1);
        verify(() => mockSnackBarService.showCommonError()).called(1);
        expect(store.actionLog[0], const TypeMatcher<FailedToEditHomeAction>());
        expect(store.actionLog.length, 1);
      });

      test('''on successful home update edit app 
          notified and edit screen popped''', () async {

        editedHome = homeToEdit.copyWith(avatarUrl: 'some avatar url');

        store = TestStore<AppState>(
          appReducer,
          initialState: AppState.initial().copyWith(
              editHomeState: EditHomeState.initial().copyWith(
            editedHome: homeToEdit,
            pickedAvatar: newAvatar,
          )),
          middleware: [middleware],
        );

        when(() => mockHomeService.editHome(
              homeToEdit: homeToEdit,
              newAvatar: newAvatar,
            )).thenAnswer((_) => Future.value(editedHome));

        await middleware.process(store, EditHomeAction());

        verify(() => mockHomeService.editHome(
              homeToEdit: homeToEdit,
              newAvatar: newAvatar,
            )).called(1);
        verifyZeroInteractions(mockFileService);
        verifyZeroInteractions(mockSnackBarService);
        expect(store.actionLog[0], const TypeMatcher<HomeEditedAction>());
        expect(store.actionLog[0].editedHome, equals(editedHome));
        expect(store.actionLog[1], const TypeMatcher<PopNavigationAction>());
        expect(store.actionLog.length, 2);
      });

      test('''check delete old avatar performed''', () async {

        store = TestStore<AppState>(
          appReducer,
          initialState: AppState.initial().copyWith(
              editHomeState: EditHomeState.initial().copyWith(
                  pickedAvatar: newAvatar,
                  editedHome: homeToEdit,
                  initialHome: initialHome)),
          middleware: [middleware],
        );

        when(() => mockHomeService.editHome(
            homeToEdit: homeToEdit,
            newAvatar: newAvatar)).thenAnswer((_) => Future.value(editedHome));
        when(() => mockFileService.removePicture(oldAvatarUrl))
            .thenAnswer((_) => Future.value());

        await middleware.process(store, EditHomeAction());

        verify(() => mockHomeService.editHome(
              homeToEdit: homeToEdit,
              newAvatar: newAvatar,
            )).called(1);
        verify(() => mockFileService.removePicture(oldAvatarUrl)).called(1);
      });
    },
  );
}
