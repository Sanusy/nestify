import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nestify/redux/app_reducer.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/settings/middleware/contact_support_middleware.dart';
import 'package:nestify/redux/settings/settings_action.dart';
import 'package:nestify/service/constants_service/constants_service.dart';
import 'package:nestify/service/external_activities_service/external_activities_service.dart';
import 'package:nestify/service/network_error.dart';

import '../test_store.dart';

class MockConstantsService extends Mock implements ConstantsService {}

class MockExternalActivitiesService extends Mock
    implements ExternalActivitiesService {}

void main() {
  group('Contact support middleware tests', () {
    late TestStore<AppState> store;
    late ConstantsService constantsService;
    late ExternalActivitiesService externalActivitiesService;
    late ContactSupportMiddleware middleware;

    setUp(() {
      constantsService = MockConstantsService();
      externalActivitiesService = MockExternalActivitiesService();

      middleware =
          ContactSupportMiddleware(constantsService, externalActivitiesService);

      store = TestStore<AppState>(
        appReducer,
        initialState: AppState.initial(),
        middleware: [middleware],
      );
    });

    test('''Check successful contact support flow''', () async {
      const supportEmail = 'support email';
      when(() => constantsService.supportEmail())
          .thenAnswer((_) => Future.value(supportEmail));
      when(() => externalActivitiesService.mainTo(supportEmail))
          .thenAnswer((invocation) => Future.value());

      await middleware.process(store, ContactSupportAction());

      verify(() => constantsService.supportEmail()).called(1);
      verify(() => externalActivitiesService.mainTo(supportEmail)).called(1);
      expect(
          store.actionLog[0], const TypeMatcher<ContactSupportOpenedAction>());
      expect(store.actionLog.length, 1);
    });

    test('Check fail contact support flow', () async {
      const supportEmail = 'support email';
      when(() => constantsService.supportEmail())
          .thenThrow(const NetworkError.unknown());
      when(() => externalActivitiesService.mainTo(supportEmail))
          .thenAnswer((invocation) => Future.value());

      await middleware.process(store, ContactSupportAction());

      verify(() => constantsService.supportEmail()).called(1);
      verifyNever(() => externalActivitiesService.mainTo(supportEmail));
      expect(store.actionLog[0],
          const TypeMatcher<FailedToContactSupportAction>());
      expect(store.actionLog.length, 1);
    });
  });
}
