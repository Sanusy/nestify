import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nestify/models/home.dart';
import 'package:nestify/models/nestify_user.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_reducer.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/home/home_state.dart';
import 'package:nestify/redux/home_profile/home_profile_action.dart';
import 'package:nestify/redux/home_profile/middleware/leave_home_middleware.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:nestify/service/snack_bar_service/snack_bar_service.dart';

import '../../test_store.dart';

class MockHomeService extends Mock implements HomeService {}

class MockSnackBarService extends Mock implements SnackBarService {}

void main() {
  group(
    'Leave home middleware tests',
    () {
      late TestStore<AppState> store;
      late HomeService mockHomeService;
      late SnackBarService mockSnackBarService;
      late LeaveHomeMiddleware middleware;

      const homeId = 'home id';
      const homeToLeave = Home(
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
        middleware = LeaveHomeMiddleware(
          mockHomeService,
          mockSnackBarService,
        );

        store = TestStore<AppState>(
          appReducer,
          initialState: AppState.initial().copyWith(
              homeState: HomeState.initial().copyWith(
            home: homeToLeave,
          )),
          middleware: [middleware],
        );
      });

      test('''on successful leave home user navigated to homeless user 
      screen and notifies other components about user left home''', () async {
        when(() => mockHomeService.leaveHome(
              homeId: homeId,
            )).thenAnswer((_) async => Future.value());

        await middleware.process(store, LeaveHomeAction());

        verify(() => mockHomeService.leaveHome(
              homeId: homeId,
            )).called(1);
        expect(store.actionLog.length, 2);
        expect(
            store.actionLog[0], SetPathNavigationAction(HomelessUserRoute()));
        expect(store.actionLog[1], const TypeMatcher<LeavedHomeAction>());
      });

      test('''on failed leave home error shown to user 
      and notifies other components about leave home failed''', () async {
        when(() => mockHomeService.leaveHome(
              homeId: homeId,
            )).thenThrow(const NetworkError.unknown());

        await middleware.process(store, LeaveHomeAction());

        verify(() => mockHomeService.leaveHome(
              homeId: homeId,
            )).called(1);
        expect(store.actionLog.length, 1);
        expect(
          store.actionLog[0],
          const TypeMatcher<FailedToLeaveHomeAction>(),
        );
      });

      test('''on leave home with new admin, 
          new admin id passed to leave home''', () async {
        const newAdminId = 'new admin id';
        const newAdmin = NestifyUser(
          id: newAdminId,
          userName: 'userName',
          homeId: homeId,
          colorId: 'colorId',
          bio: 'bio',
          avatarUrl: 'avatarUrl',
        );
        store.dispatch(SelectNewAdminAction(newAdmin));
        when(() => mockHomeService.leaveHome(
              homeId: homeId,
              newAdminId: newAdminId,
            )).thenAnswer((_) async => Future.value());

        await middleware.process(store, LeaveHomeAction());

        verify(() => mockHomeService.leaveHome(
              homeId: homeId,
              newAdminId: newAdminId,
            )).called(1);
        expect(store.actionLog.length, 3);
        expect(
            store.actionLog[1], SetPathNavigationAction(HomelessUserRoute()));
        expect(store.actionLog[2], const TypeMatcher<LeavedHomeAction>());
      });
    },
  );
}
