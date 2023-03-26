import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/create_home/create_home_action.dart';
import 'package:nestify/redux/create_home/create_home_state.dart';
import 'package:nestify/redux/middleware/create_home_middleware.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/redux/reducer.dart';
import 'package:nestify/service/dto/update_home_dto.dart';
import 'package:nestify/service/file_error.dart';
import 'package:nestify/service/file_service/file_service.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:nestify/service/user_service/user_service.dart';

import '../test_store.dart';

class MockHomeService extends Mock implements HomeService {}

class MockFileService extends Mock implements FileService {}

class MockUserService extends Mock implements UserService {}

class FakeUpdateHomeDto extends Fake implements UpdateHomeDto {}

class FakeFile extends Fake implements File {}

void main() {
  group('Create Home profile middleware test group', () {
    late HomeService homeService;
    late FileService fileService;
    late UserService userService;
    late CreateHomeMiddleware middleware;
    late TestStore<AppState> store;

    setUpAll(() {
      registerFallbackValue(FakeUpdateHomeDto());
      registerFallbackValue(FakeFile());
    });

    setUp(() {
      homeService = MockHomeService();
      fileService = MockFileService();
      userService = MockUserService();
      middleware = CreateHomeMiddleware(homeService, fileService, userService);
      store = TestStore<AppState>(
        appReducer,
        initialState: AppState.initial(),
        middleware: [middleware],
      );
    });

    test(
        '''Check creating home without avatar does not call upload avatar,
         then after success dispatch success action and navigates to create
          user profile''',
        () async {
      when(() => userService.homeId()).thenAnswer((_) async => 'home draft id');
      when(() => homeService.createHome(any()))
          .thenAnswer((_) => Future.value());

      await middleware.process(store, CreateHomeAction());

      verify(() => userService.homeId()).called(1);
      verify(() => homeService.createHome(any())).called(1);
      verifyNever(() => fileService.uploadHomeAvatar(any(), any()));
      expect(store.actionLog[0], const TypeMatcher<HomeCreatedAction>());
      expect(store.actionLog[1],
          const NavigationAction.replace(AppRoute.createUserProfile()));
      expect(store.actionLog.length, 2);
    });

    test('''Check creating home with avatar call upload avatar successfuly,
         then after success dispatch success action and navigates to create
          user profile''', () async {
      // Setting up avatar file inside store
      store = TestStore(
        appReducer,
        initialState: AppState.initial().copyWith(
          createHomeState: CreateHomeState.initial().copyWith(
            avatar: FakeFile(),
          ),
        ),
      );
      when(() => userService.homeId()).thenAnswer((_) async => 'home draft id');
      when(() => homeService.createHome(any()))
          .thenAnswer((_) => Future.value());
      when(() => fileService.uploadHomeAvatar(any(), any())).thenAnswer(
        (_) async => 'avatar url',
      );

      await middleware.process(store, CreateHomeAction());

      verifyInOrder([
        () => userService.homeId(),
        () => fileService.uploadHomeAvatar(any(), any()),
        () => homeService.createHome(any()),
      ]);
      expect(store.actionLog[0], const TypeMatcher<HomeCreatedAction>());
      expect(store.actionLog[1],
          const NavigationAction.replace(AppRoute.createUserProfile()));
      expect(store.actionLog.length, 2);
    });

    test('''Check creating home with avatar call upload avatar with fail,
         then after fail dispatch fail action''', () async {
      // Setting up avatar file inside store
      store = TestStore(
        appReducer,
        initialState: AppState.initial().copyWith(
          createHomeState: CreateHomeState.initial().copyWith(
            avatar: FakeFile(),
          ),
        ),
      );
      when(() => userService.homeId()).thenAnswer((_) async => 'home draft id');
      when(() => homeService.createHome(any()))
          .thenAnswer((_) => Future.value());
      when(() => fileService.uploadHomeAvatar(any(), any()))
          .thenThrow(const FileError.failedToUpload());

      await middleware.process(store, CreateHomeAction());

      verify(() => userService.homeId()).called(1);
      verify(() => fileService.uploadHomeAvatar(any(), any())).called(1);
      verifyNever(() => homeService.createHome(any()));
      expect(store.actionLog[0], const TypeMatcher<FailedToCreateHomeAction>());
      expect(store.actionLog.length, 1);
    });

    test('''Check creating home fail dispatches fail action''', () async {
      when(() => userService.homeId()).thenAnswer((_) async => 'home draft id');
      when(() => homeService.createHome(any()))
          .thenThrow(const NetworkError.unknown());

      await middleware.process(store, CreateHomeAction());

      verify(() => userService.homeId()).called(1);
      verify(() => homeService.createHome(any())).called(1);
      expect(store.actionLog[0], const TypeMatcher<FailedToCreateHomeAction>());
      expect(store.actionLog.length, 1);
    });
  });
}
