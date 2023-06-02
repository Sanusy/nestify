import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nestify/models/home.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_reducer.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/create_home/create_home_state.dart';
import 'package:nestify/redux/join_home/join_home_action.dart';
import 'package:nestify/redux/join_home/join_home_state.dart';
import 'package:nestify/redux/join_home/middleware/join_home_middleware.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/service/file_error.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:nestify/service/snack_bar_service/snack_bar_service.dart';

import '../test_store.dart';

class MockHomeService extends Mock implements HomeService {}

class MockSnackBarService extends Mock implements SnackBarService {}

void main() {
  group(
    'Join home middleware tests',
    () {
      late TestStore<AppState> store;
      late HomeService mockHomeService;
      late SnackBarService mockSnackBarService;
      late JoinHomeMiddleware middleware;

      late UserProfileDraftState userDraft;

      const homeId = 'home id';
      const homeToJoin = Home(
        id: homeId,
        homeName: 'homeName',
        adminId: 'adminId',
        usersIds: ['usersIds'],
        address: 'address',
        about: 'about',
        avatarUrl: 'avatarUrl',
      );

      setUp(() {
        mockHomeService = MockHomeService();
        mockSnackBarService = MockSnackBarService();
        middleware = JoinHomeMiddleware(
          mockHomeService,
          mockSnackBarService,
        );

        userDraft = UserProfileDraftState.initial();

        store = TestStore<AppState>(
          appReducer,
          initialState: AppState.initial().copyWith(
              joinHomeState: JoinHomeState.initial().copyWith(
                homeToJoin: homeToJoin,
            userProfileDraftState: userDraft,
          )),
          middleware: [middleware],
        );
      });

      test('''on successful join home user navigated to home''', () async {
        when(() => mockHomeService.joinHome(
              homeId: homeId,
              userDraft: userDraft,
            )).thenAnswer((_) async => Future.value());
        await middleware.process(store, JoinHomeAction());

        verify(() => mockHomeService.joinHome(
              homeId: homeId,
              userDraft: userDraft,
            )).called(1);
        expect(store.actionLog[0], SetPathNavigationAction(HomeRoute()));
        expect(store.actionLog.length, 1);
      });

      test('''on failed to upload avatars user sees error''', () async {
        when(() => mockHomeService.joinHome(
              homeId: homeId,
              userDraft: userDraft,
            )).thenThrow(const FileError.failedToUpload());

        await middleware.process(store, JoinHomeAction());

        verify(() => mockHomeService.joinHome(
              homeId: homeId,
              userDraft: userDraft,
            )).called(1);
        verify(() => mockSnackBarService.showCommonError()).called(1);
        expect(store.actionLog[0], const TypeMatcher<FailedToJoinHomeAction>());
        expect(store.actionLog.length, 1);
      });

      test('''on failed to create home user sees error''', () async {
        when(() =>
                mockHomeService.joinHome(homeId: homeId, userDraft: userDraft))
            .thenThrow(const NetworkError.unknown());
        await middleware.process(store, JoinHomeAction());

        verify(() => mockHomeService.joinHome(
              homeId: homeId,
              userDraft: userDraft,
            )).called(1);
        verify(() => mockSnackBarService.showCommonError()).called(1);
        expect(store.actionLog[0], const TypeMatcher<FailedToJoinHomeAction>());
        expect(store.actionLog.length, 1);
      });
    },
  );
}
