import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nestify/models/home.dart';
import 'package:nestify/models/user.dart';
import 'package:nestify/models/user_color.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_reducer.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/home/home_action.dart';
import 'package:nestify/redux/home/middleware/init_home_middleware.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:nestify/service/user_service/user_service.dart';

import '../../test_store.dart';

class MockUserService extends Mock implements UserService {}

class MockHomeService extends Mock implements HomeService {}

void main() {
  group('Contact support middleware tests', () {
    late TestStore<AppState> store;
    late UserService userService;
    late HomeService homeService;
    late InitHomeMiddleware middleware;

    const homeId = 'homeId';
    const userId = 'userId';
    const usersIds = [userId];
    const home = Home(
      id: homeId,
      homeName: 'homeName',
      adminId: userId,
      usersIds: usersIds,
      address: 'address',
      about: 'about',
      avatarUrl: 'avatarUrl',
    );
    const user = User(
      id: userId,
      userName: 'userName',
      homeId: homeId,
      colorId: 'colorId',
      bio: 'bio',
      avatarUrl: 'avatarUrl',
    );

    setUp(() {
      userService = MockUserService();
      homeService = MockHomeService();

      middleware = InitHomeMiddleware(homeService, userService);

      store = TestStore<AppState>(
        appReducer,
        initialState: AppState.initial(),
        middleware: [middleware],
      );
    });

    test('''not logged in user navigated to log in screen''', () async {
      when(() => userService.currentUserId()).thenReturn(null);

      await middleware.process(store, InitHomeAction());

      verify(() => userService.currentUserId()).called(1);
      verifyZeroInteractions(homeService);
      expect(store.actionLog.length, 1);
      expect(store.actionLog[0], SetPathNavigationAction(LoginRoute()));
    });

    test('''user without home navigated to homeless user screen''', () async {
      when(() => userService.currentUserId()).thenReturn(userId);
      when(() => userService.homeId()).thenAnswer((_) => Future.value(null));

      await middleware.process(store, InitHomeAction());

      verify(() => userService.currentUserId()).called(1);
      verify(() => userService.homeId()).called(1);
      verifyZeroInteractions(homeService);
      expect(store.actionLog.length, 1);
      expect(store.actionLog[0], SetPathNavigationAction(HomelessUserRoute()));
    });

    test('''on colors loading error fail action dispatched''', () async {
      when(() => userService.currentUserId()).thenReturn(userId);
      when(() => userService.homeId()).thenAnswer((_) => Future.value(homeId));
      when(() => homeService.availableColors())
          .thenThrow(const NetworkError.unknown());

      await middleware.process(store, InitHomeAction());

      verify(() => userService.currentUserId()).called(1);
      verify(() => userService.homeId()).called(1);
      verify(() => homeService.availableColors()).called(1);
      verifyNever(() => homeService.home(homeId));
      verifyNever(() => homeService.homeUsers(usersIds));
      expect(store.actionLog.length, 1);
      expect(store.actionLog[0], const TypeMatcher<FailedToInitHomeAction>());
    });

    test('''on initial home loading error fail action dispatched''', () async {
      when(() => userService.currentUserId()).thenReturn(userId);
      when(() => userService.homeId()).thenAnswer((_) => Future.value(homeId));
      when(() => homeService.availableColors())
          .thenAnswer((_) => Future.value([]));
      when(() => homeService.home(homeId))
          .thenThrow(const NetworkError.unknown());

      await middleware.process(store, InitHomeAction());

      verify(() => userService.currentUserId()).called(1);
      verify(() => userService.homeId()).called(1);
      verify(() => homeService.availableColors()).called(1);
      verify(() => homeService.home(homeId)).called(1);
      verifyNever(() => homeService.homeUsers(usersIds));
      expect(store.actionLog.length, 1);
      expect(store.actionLog[0], const TypeMatcher<FailedToInitHomeAction>());
    });

    test('''on initial users loading error fail action dispatched''', () async {
      when(() => userService.currentUserId()).thenReturn(userId);
      when(() => userService.homeId()).thenAnswer((_) => Future.value(homeId));
      when(() => homeService.availableColors())
          .thenAnswer((_) => Future.value([]));
      when(() => homeService.home(homeId))
          .thenAnswer((_) => Future.value(home));
      when(() => homeService.homeUsers(usersIds))
          .thenThrow(const NetworkError.unknown());

      await middleware.process(store, InitHomeAction());

      verify(() => userService.currentUserId()).called(1);
      verify(() => userService.homeId()).called(1);
      verify(() => homeService.availableColors()).called(1);
      verify(() => homeService.home(homeId)).called(1);
      verify(() => homeService.homeUsers(usersIds)).called(1);
      expect(store.actionLog.length, 1);
      expect(store.actionLog[0], const TypeMatcher<FailedToInitHomeAction>());
    });

    test('''on initial data loaded home initialized action dispatched''',
        () async {
      final availableColors = [
        const UserColor(id: 'id', ru: 'ru', en: 'en', hex: 'hex'),
      ];
      final homeUsers = [user];

      when(() => userService.currentUserId()).thenReturn(userId);
      when(() => userService.homeId()).thenAnswer((_) => Future.value(homeId));
      when(() => homeService.availableColors())
          .thenAnswer((_) => Future.value(availableColors));
      when(() => homeService.home(homeId))
          .thenAnswer((_) => Future.value(home));
      when(() => homeService.homeUsers(usersIds))
          .thenAnswer((_) => Future.value(homeUsers));

      await middleware.process(store, InitHomeAction());

      verify(() => userService.currentUserId()).called(1);
      verify(() => userService.homeId()).called(1);
      verify(() => homeService.availableColors()).called(1);
      verify(() => homeService.home(homeId)).called(1);
      verify(() => homeService.homeUsers(usersIds)).called(1);
      expect(store.actionLog.length, 1);
      expect(store.actionLog[0], const TypeMatcher<HomeInitializedAction>());

      final homeInitializedAction = store.actionLog[0] as HomeInitializedAction;
      expect(homeInitializedAction.home, home);
      expect(homeInitializedAction.users, homeUsers);
      expect(homeInitializedAction.currentUserId, userId);
      expect(homeInitializedAction.colors, availableColors);
    });
  });
}
