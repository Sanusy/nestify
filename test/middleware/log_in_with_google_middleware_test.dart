import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/login/login_action.dart';
import 'package:nestify/redux/login/middleware/login_with_google_middleware.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/redux/reducer.dart';
import 'package:nestify/service/network_error.dart';
import 'package:nestify/service/user_service/user_service.dart';

import '../test_store.dart';

class MockUserService extends Mock implements UserService {}

void main() {
  group(
    'Log in with Google middleware tests',
    () {
      late TestStore<AppState> store;
      late UserService mockUserService;
      late LoginWithGoogleMiddleware middleware;

      setUp(() {
        mockUserService = MockUserService();
        middleware = LoginWithGoogleMiddleware(mockUserService);
        store = TestStore<AppState>(
          appReducer,
          initialState: AppState.initial(),
          middleware: [middleware],
        );
      });

      test('''Check successful login 
          dispatch success action and navigates to root tab bar''', () async {
        when(() => mockUserService.logInWithGoogle())
            .thenAnswer((_) async => 'returned user id');
        await middleware.process(store, LoginWithGoogleAction());

        verify(() => mockUserService.logInWithGoogle()).called(1);
        expect(store.actionLog[0], const TypeMatcher<LoginSuccessAction>());
        expect(
          store.actionLog[1],
          const NavigationAction.setPath(AppRoute.splash()),
        );
      });

      test('''Check failed login dispatch fail action''', () async {
        when(() => mockUserService.logInWithGoogle())
            .thenThrow(const NetworkError.unknown());
        await middleware.process(store, LoginWithGoogleAction());

        verify(() => mockUserService.logInWithGoogle()).called(1);
        expect(store.actionLog[0], const TypeMatcher<FailedToLoginAction>());
      });
    },
  );
}
