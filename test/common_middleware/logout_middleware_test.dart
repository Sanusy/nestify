import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_reducer.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/common_middlewares/common_actions.dart';
import 'package:nestify/redux/common_middlewares/logout_middleware.dart';
import 'package:nestify/redux/dynamic_links/dynamic_links_action.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/service/user_service/user_service.dart';

import '../test_store.dart';

class MockUserService extends Mock implements UserService {}

void main() {
  group(
    'Log in with Google middleware tests',
    () {
      late TestStore<AppState> store;
      late UserService mockUserService;
      late LogoutMiddleware middleware;

      setUp(() {
        mockUserService = MockUserService();
        middleware = LogoutMiddleware(mockUserService);
        store = TestStore<AppState>(
          appReducer,
          initialState: AppState.initial(),
          middleware: [middleware],
        );
      });

      test('Check successful logout navigates to login screen', () async {
        when(() => mockUserService.logOut()).thenAnswer((_) => Future.value());
        await middleware.process(store, LogoutAction());

        verify(() => mockUserService.logOut()).called(1);
        expect(store.actionLog[0],
            const TypeMatcher<StopListenDynamicLinksAction>());
        expect(store.actionLog[1], SetPathNavigationAction(LoginRoute()));
        expect(store.actionLog.length, 2);
      });
    },
  );
}
