import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nestify/models/home.dart';
import 'package:nestify/models/user.dart';
import 'package:nestify/models/user_color.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/join_home/join_home_action.dart';
import 'package:nestify/redux/join_home/middleware/init_join_home_middleware.dart';
import 'package:nestify/redux/app_reducer.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';

import '../../test_store.dart';

class MockHomeService extends Mock implements HomeService {}

void main() {
  group('Join home initialization test', () {
    late TestStore<AppState> store;
    late HomeService homeService;
    late InitJoinHomeMiddleware middleware;

    const userId = 'user id';

    const homeToJoin = Home(
      id: 'id',
      homeName: 'homeName',
      adminId: userId,
      usersIds: [userId],
      address: 'address',
      about: 'about',
      avatarUrl: 'avatarUrl',
    );

    final colorsList = [
      const UserColor(
        id: 'id',
        ru: 'ru',
        en: 'en',
        hex: 'hex',
      ),
    ];
    final homeUsers = [
      const User(
        id: userId,
        userName: 'userName',
        homeId: 'homeId',
        colorId: 'colorId',
        bio: 'bio',
        avatarUrl: 'avatarUrl',
      ),
    ];

    setUp(() {
      homeService = MockHomeService();

      middleware = InitJoinHomeMiddleware(homeService);

      store = TestStore<AppState>(
        appReducer,
        initialState: AppState.initial(),
        middleware: [middleware],
      );
    });

    test('''colors and home users loaded and passed successfully''', () async {
      when(() => homeService.availableColors())
          .thenAnswer((_) => Future.value(colorsList));
      when(() => homeService.homeUsers(homeToJoin.usersIds))
          .thenAnswer((_) => Future.value(homeUsers));

      await middleware.process(
          store, InitJoinHomeAction(homeToJoin: homeToJoin));

      verify(() => homeService.availableColors()).called(1);
      verify(() => homeService.homeUsers(homeToJoin.usersIds)).called(1);
      expect(
          store.actionLog[0], const TypeMatcher<JoinHomeInitializedAction>());
      expect(store.actionLog[0].colors, colorsList);
      expect(store.actionLog[0].users, homeUsers);
      expect(store.actionLog.length, 1);
    });

    test('''when colors failed to load error dispatched''', () async {
      when(() => homeService.availableColors())
          .thenThrow(const NetworkError.unknown());

      await middleware.process(
          store, InitJoinHomeAction(homeToJoin: homeToJoin));

      verify(() => homeService.availableColors()).called(1);
      verifyNever(() => homeService.homeUsers(homeToJoin.usersIds));
      expect(
        store.actionLog[0],
        const TypeMatcher<FailedToInitJoinHomeAction>(),
      );
      expect(store.actionLog.length, 1);
    });

    test('''when users failed to load error dispatched''', () async {
      when(() => homeService.availableColors())
          .thenAnswer((_) => Future.value(colorsList));
      when(() => homeService.homeUsers(homeToJoin.usersIds))
          .thenThrow(const NetworkError.unknown());

      await middleware.process(
          store, InitJoinHomeAction(homeToJoin: homeToJoin));

      verify(() => homeService.availableColors()).called(1);
      verify(() => homeService.homeUsers(homeToJoin.usersIds)).called(1);
      expect(
        store.actionLog[0],
        const TypeMatcher<FailedToInitJoinHomeAction>(),
      );
      expect(store.actionLog.length, 1);
    });
  });
}
