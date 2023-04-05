import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nestify/models/user_color.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/create_home/create_home_action.dart';
import 'package:nestify/redux/create_home/middleware/load_available_colors_middleware.dart';
import 'package:nestify/redux/reducer.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';

import '../test_store.dart';

class MockHomeService extends Mock implements HomeService {}

void main() {
  group('Load available colors on create home', () {
    late TestStore<AppState> store;
    late LoadAvailableColorsMiddleware middleware;
    late HomeService homeService;

    setUp(() {
      homeService = MockHomeService();

      middleware = LoadAvailableColorsMiddleware(homeService);

      store = TestStore(
        appReducer,
        initialState: AppState.initial(),
        middleware: [middleware],
      );
    });

    test(
        'on successful colors load, colors loaded action dispatched with correct colors list',
        () async {
      final colorsList = [
        const UserColor(id: 'id', ru: 'ru', en: 'en', hex: 'hex')
      ];
      when(() => homeService.availableColors())
          .thenAnswer((_) async => colorsList);

      await middleware.process(store, LoadAvailableColorsAction());

      verify(() => homeService.availableColors()).called(1);
      expect(
          store.actionLog[0], const TypeMatcher<LoadedAvailableColorsAction>());
      expect(
          (store.actionLog[0] as LoadedAvailableColorsAction).availableColors,
          colorsList);
      expect(store.actionLog.length, 1);
    });

    test('on failed to load colors, error dispatched', () async {
      when(() => homeService.availableColors())
          .thenThrow(const NetworkError.unknown());

      await middleware.process(store, LoadAvailableColorsAction());

      verify(() => homeService.availableColors()).called(1);
      expect(store.actionLog[0],
          const TypeMatcher<FailedToLoadAvailableColorsAction>());
      expect(store.actionLog.length, 1);
    });
  });
}
