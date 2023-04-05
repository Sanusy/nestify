import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/create_home/create_home_action.dart';
import 'package:nestify/redux/create_home/middleware/create_home_pick_home_avatar_middleware.dart';
import 'package:nestify/redux/reducer.dart';
import 'package:nestify/service/file_error.dart';
import 'package:nestify/service/file_service/file_service.dart';

import '../test_store.dart';

class MockFileService extends Mock implements FileService {}

void main() {
  group('Pick home avatar on create home', () {
    late TestStore<AppState> store;
    late FileService fileService;
    late CreateHomePickHomeAvatarMiddleware middleware;

    setUp(() {
      fileService = MockFileService();
      middleware = CreateHomePickHomeAvatarMiddleware(fileService);
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

      await middleware.process(store, CreateHomePickHomeAvatarAction());

      verify(() => fileService.pictureFromGallery()).called(1);
      expect(store.actionLog[0],
          const TypeMatcher<CreateHomeAvatarPickedAction>());
      expect(store.actionLog[0].avatar, pickedAvatar);
      expect(store.actionLog.length, 1);
    });

    test('Check avatar pick canceled nothing happens', () async {
      when(() => fileService.pictureFromGallery()).thenAnswer(
        (_) => Future.value(),
      );

      await middleware.process(store, CreateHomePickHomeAvatarAction());

      verify(() => fileService.pictureFromGallery()).called(1);
      expect(store.actionLog.length, 0);
    });

    test('Check avatar pick failed dispatches fail action', () async {
      when(() => fileService.pictureFromGallery()).thenThrow(
        const FileError.failedToObtain(),
      );

      await middleware.process(store, CreateHomePickHomeAvatarAction());

      verify(() => fileService.pictureFromGallery()).called(1);
      expect(
        store.actionLog[0],
        const TypeMatcher<CreateHomeFailedToPickAvatarAction>(),
      );
      expect(store.actionLog.length, 1);
    });
  });
}
