import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/create_home/create_home_action.dart';
import 'package:nestify/redux/create_home/create_home_state.dart';
import 'package:nestify/redux/create_home/middleware/create_home_middleware.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/redux/reducer.dart';
import 'package:nestify/service/file_error.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';

import '../test_store.dart';

class MockHomeService extends Mock implements HomeService {}

void main() {
  group(
    'Create home middleware tests',
    () {
      late TestStore<AppState> store;
      late HomeService mockHomeService;
      late CreateHomeMiddleware middleware;

      late HomeProfileDraftState homeDraft;
      late UserProfileDraftState userDraft;

      setUp(() {
        mockHomeService = MockHomeService();
        middleware = CreateHomeMiddleware(mockHomeService);

        homeDraft = HomeProfileDraftState.initial();
        userDraft = UserProfileDraftState.initial();

        store = TestStore<AppState>(
          appReducer,
          initialState: AppState.initial().copyWith(
              createHomeState: CreateHomeState.initial().copyWith(
            homeProfileDraftState: homeDraft,
            userProfileDraftState: userDraft,
          )),
          middleware: [middleware],
        );
      });

      test('''on successful create home user navigated to root tab bar''',
          () async {
        when(() => mockHomeService.createHome(
            homeDraft: homeDraft,
            userDraft: userDraft)).thenAnswer((_) async => Future.value());
        await middleware.process(store, CreateHomeAction());

        verify(() => mockHomeService.createHome(
              homeDraft: homeDraft,
              userDraft: userDraft,
            )).called(1);
        expect(store.actionLog[0],
            const NavigationAction.replace(AppRoute.home()));
        expect(store.actionLog.length, 1);
      });

      test('''on failed to upload avatars user sees error''', () async {
        when(() => mockHomeService.createHome(
            homeDraft: homeDraft,
            userDraft: userDraft)).thenThrow(const FileError.failedToUpload());
        await middleware.process(store, CreateHomeAction());

        verify(() => mockHomeService.createHome(
              homeDraft: homeDraft,
              userDraft: userDraft,
            )).called(1);
        expect(
            store.actionLog[0], const TypeMatcher<FailedToCreateHomeAction>());
        expect(store.actionLog.length, 1);
      });

      test('''on failed to create home user sees error''', () async {
        when(() => mockHomeService.createHome(
            homeDraft: homeDraft,
            userDraft: userDraft)).thenThrow(const NetworkError.unknown());
        await middleware.process(store, CreateHomeAction());

        verify(() => mockHomeService.createHome(
              homeDraft: homeDraft,
              userDraft: userDraft,
            )).called(1);
        expect(
            store.actionLog[0], const TypeMatcher<FailedToCreateHomeAction>());
        expect(store.actionLog.length, 1);
      });
    },
  );
}
