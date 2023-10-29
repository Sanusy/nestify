import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nestify/models/home.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/add_member/add_member_action.dart';
import 'package:nestify/redux/add_member/middleware/obtain_invite_url_middleware.dart';
import 'package:nestify/redux/app_reducer.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/home/home_state.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/service/dynamic_links_service/dynamic_links_service.dart';
import 'package:nestify/service/network_error.dart';

import '../../test_store.dart';

class MockDynamicLinkService extends Mock implements DynamicLinkService {}

void main() {
  group(
    'Obtain home invite url tests',
    () {
      late TestStore<AppState> store;
      late DynamicLinkService dynamicLinkService;
      late ObtainInviteUrlMiddleware middleware;

      const inviteUrl = 'invite url';

      const home = Home(
        id: 'home id',
        homeName: 'home name',
        adminId: 'adminId',
        usersIds: [],
        address: 'address',
        about: 'about',
        avatarUrl: 'avatar url',
      );

      setUpAll(() {
        registerFallbackValue(XFile('dummy_path'));
      });

      setUp(() {
        dynamicLinkService = MockDynamicLinkService();
        middleware = ObtainInviteUrlMiddleware(dynamicLinkService);
      });

      test('on home null redirect to homeless user page', () async {
        store = store = TestStore<AppState>(
          appReducer,
          initialState: AppState.initial(),
          middleware: [middleware],
        );

        await middleware.process(
          store,
          ObtainInviteUrlAction(),
        );

        verifyZeroInteractions(dynamicLinkService);
        expect(store.actionLog.length, 1);
        expect(
            store.actionLog[0], SetPathNavigationAction(HomelessUserRoute()));
      });

      test('on link obtained notify app', () async {
        store = store = TestStore<AppState>(
          appReducer,
          initialState: AppState.initial().copyWith(
            homeState: HomeState.initial().copyWith(home: home),
          ),
          middleware: [middleware],
        );
        when(() => dynamicLinkService.homeInviteUrl(home.id))
            .thenAnswer((_) => Future.value(inviteUrl));

        await middleware.process(
          store,
          ObtainInviteUrlAction(),
        );

        verify(() => dynamicLinkService.homeInviteUrl(home.id)).called(1);
        expect(store.actionLog.length, 1);
        expect(
            store.actionLog[0], const TypeMatcher<InviteUrlObtainedAction>());
        expect(store.actionLog[0].inviteUrl, inviteUrl);
      });

      test('on link obtain failed notify app', () async {
        store = store = TestStore<AppState>(
          appReducer,
          initialState: AppState.initial().copyWith(
            homeState: HomeState.initial().copyWith(home: home),
          ),
          middleware: [middleware],
        );
        when(() => dynamicLinkService.homeInviteUrl(home.id))
            .thenThrow(const NetworkError.unknown());

        await middleware.process(
          store,
          ObtainInviteUrlAction(),
        );

        verify(() => dynamicLinkService.homeInviteUrl(home.id)).called(1);
        expect(store.actionLog.length, 1);
        expect(store.actionLog[0],
            const TypeMatcher<FailedToObtainInviteUrlAction>());
      });
    },
  );
}
