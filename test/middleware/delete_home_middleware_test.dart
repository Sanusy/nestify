import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nestify/models/home.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_reducer.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/home/home_state.dart';
import 'package:nestify/redux/home_profile/home_profile_action.dart';
import 'package:nestify/redux/home_profile/middleware/delete_home_middleware.dart';
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
    'Delete home middleware tests',
    () {
      late TestStore<AppState> store;
      late HomeService mockHomeService;
      late SnackBarService mockSnackBarService;
      late DeleteHomeMiddleware middleware;

      const homeId = 'home id';
      const homeToDelete = Home(
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
        middleware = DeleteHomeMiddleware(
          mockHomeService,
          mockSnackBarService,
        );

        store = TestStore<AppState>(
          appReducer,
          initialState: AppState.initial().copyWith(
              homeState: HomeState.initial().copyWith(
            home: homeToDelete,
          )),
          middleware: [middleware],
        );
      });

      test('''on successful delete home user navigated to homeless user 
      screen and notifies other components about home deletion''', () async {
        when(() => mockHomeService.deleteHome(
              homeToDelete: homeToDelete,
            )).thenAnswer((_) async => Future.value());
        await middleware.process(store, DeleteHomeAction());

        verify(() => mockHomeService.deleteHome(
              homeToDelete: homeToDelete,
            )).called(1);
        expect(store.actionLog.length, 2);
        expect(
            store.actionLog[0], SetPathNavigationAction(HomelessUserRoute()));
        expect(store.actionLog[1], const TypeMatcher<HomeDeletedAction>());
      });

      test('''on failed delete home error shown to user 
      and notifies other components about home deletion failed''', () async {
        when(() => mockHomeService.deleteHome(
              homeToDelete: homeToDelete,
            )).thenThrow(const NetworkError.unknown());
        await middleware.process(store, DeleteHomeAction());

        verify(() => mockHomeService.deleteHome(
              homeToDelete: homeToDelete,
            )).called(1);
        expect(store.actionLog.length, 1);
        expect(
          store.actionLog[0],
          const TypeMatcher<FailedToDeleteHomeAction>(),
        );
      });

      test('''on failed delete home avatar nothing happens''', () async {
        when(() => mockHomeService.deleteHome(
              homeToDelete: homeToDelete,
            )).thenThrow(const FileError.failedToDelete());
        await middleware.process(store, DeleteHomeAction());

        verify(() => mockHomeService.deleteHome(
              homeToDelete: homeToDelete,
            )).called(1);
        verifyZeroInteractions(mockSnackBarService);
        expect(store.actionLog.length, 0);
      });
    },
  );
}
