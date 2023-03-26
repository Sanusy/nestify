import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/homeless_user/homeless_user_action.dart';
import 'package:nestify/redux/middleware/create_home_draft_middleware.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/redux/reducer.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';

import '../test_store.dart';

class MockHomeService extends Mock implements HomeService {}

void main() {
  group('Create home draft middleware tests', () {
    late TestStore<AppState> store;
    late HomeService homeService;
    late CreateHomeDraftMiddleware middleware;

    setUp(() {
      homeService = MockHomeService();
      middleware = CreateHomeDraftMiddleware(homeService);
      store = TestStore<AppState>(
        appReducer,
        initialState: AppState.initial(),
        middleware: [middleware],
      );
    });

    test(
        'Check after successful draft creation, dispatch success action and navigates to create home',
        () async {
      when(() => homeService.createHomeDraft())
          .thenAnswer((_) => Future.value());

      await middleware.process(store, CreateHomeDraftAction());

      verify(() => homeService.createHomeDraft()).called(1);
      expect(store.actionLog[0], const TypeMatcher<CreatedHomeDraftAction>());
      expect(store.actionLog[1],
          const NavigationAction.replace(AppRoute.createHome()));
      expect(store.actionLog.length, 2);
    });

    test('Check after failed draft creation, dispatch fail action', () async {
      when(() => homeService.createHomeDraft())
          .thenThrow(const NetworkError.unknown());

      await middleware.process(store, CreateHomeDraftAction());

      verify(() => homeService.createHomeDraft()).called(1);
      expect(store.actionLog[0],
          const TypeMatcher<FailedToOpenCreateHomeAction>());
      expect(store.actionLog.length, 1);
    });
  });
}
