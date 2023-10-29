import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nestify/redux/app_reducer.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/join_home/join_home_action.dart';
import 'package:nestify/redux/join_home/middleware/join_home_pick_user_avatar_middleware.dart';
import 'package:nestify/service/file_error.dart';
import 'package:nestify/service/file_service/file_service.dart';
import 'package:nestify/service/snack_bar_service/snack_bar_service.dart';

import '../../test_store.dart';

class MockFileService extends Mock implements FileService {}

class MockSnackBarService extends Mock implements SnackBarService {}

void main() {
  group('Pick user avatar on join home test group', () {
    late TestStore<AppState> store;
    late FileService fileService;
    late SnackBarService snackBarService;
    late JoinHomePickUserAvatarMiddleware middleware;

    setUp(() {
      fileService = MockFileService();
      snackBarService = MockSnackBarService();
      middleware = JoinHomePickUserAvatarMiddleware(
        fileService,
        snackBarService,
      );
      store = TestStore<AppState>(
        appReducer,
        initialState: AppState.initial(),
        middleware: [middleware],
      );
    });

    test('''Check successful avatar pick dispatch 
    successful pick action with picked avatar''', () async {
      final pickedAvatar = File('');
      when(() => fileService.pictureFromGallery())
          .thenAnswer((_) => Future.value(pickedAvatar));

      await middleware.process(store, JoinHomePickUserAvatarAction());

      verify(() => fileService.pictureFromGallery()).called(1);
      expect(store.actionLog[0],
          const TypeMatcher<JoinHomeUserAvatarPickedAction>());
      expect(store.actionLog[0].avatar, pickedAvatar);
      expect(store.actionLog.length, 1);
    });

    test('Check avatar pick canceled nothing happens', () async {
      when(() => fileService.pictureFromGallery()).thenAnswer(
        (_) => Future.value(),
      );

      await middleware.process(store, JoinHomePickUserAvatarAction());

      verify(() => fileService.pictureFromGallery()).called(1);
      verifyZeroInteractions(snackBarService);
      expect(store.actionLog.length, 0);
    });

    test('Check avatar pick failed shows error', () async {
      when(() => fileService.pictureFromGallery()).thenThrow(
        const FileError.failedToObtain(),
      );

      await middleware.process(store, JoinHomePickUserAvatarAction());

      verify(() => fileService.pictureFromGallery()).called(1);
      verify(() => snackBarService.showFailedToObtainPhoto()).called(1);
      expect(store.actionLog.length, 0);
    });
  });
}
