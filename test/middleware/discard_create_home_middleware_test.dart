import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/create_home/create_home_action.dart';
import 'package:nestify/redux/middleware/discard_create_home_middleware.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/redux/reducer.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';

import '../test_store.dart';

class MockHomeService extends Mock implements HomeService {}

void main() {
  group('Discard create home middleware tests', () {
    late TestStore<AppState> store;
    late HomeService homeService;
    late DiscardCreateHomeMiddleware middleware;

    setUp(() {
      homeService = MockHomeService();
      middleware = DiscardCreateHomeMiddleware(homeService);
      store = TestStore<AppState>(
        appReducer,
        initialState: AppState.initial(),
        middleware: [middleware],
      );
    });

    test('''Check successful home creation discard
     navigates to homeless user''', () async {
      when(() => homeService.discardCreateHome())
          .thenAnswer((_) => Future.value());

      await middleware.process(store, DiscardCreateHomeAction());

      verify(() => homeService.discardCreateHome()).called(1);
      expect(store.actionLog[0],
          const NavigationAction.replace(AppRoute.homelessUser()));
      expect(store.actionLog.length, 1);
    });

    test('''Check failed home creation discard
     dispatches fail action''', () async {
      when(() => homeService.discardCreateHome())
          .thenThrow(const NetworkError.unknown());

      await middleware.process(store, DiscardCreateHomeAction());

      verify(() => homeService.discardCreateHome()).called(1);
      expect(
          store.actionLog[0], const TypeMatcher<FailedToDiscardCreateHome>());
      expect(store.actionLog.length, 1);
    });
  });
}
