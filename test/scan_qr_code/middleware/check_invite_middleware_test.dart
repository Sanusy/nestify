import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nestify/models/home.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_reducer.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/join_home/join_home_action.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/redux/scan_qr_code/middleware/check_invite_middleware.dart';
import 'package:nestify/redux/scan_qr_code/scan_qr_code_action.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:nestify/service/snack_bar_service/snack_bar_service.dart';

import '../../test_store.dart';

class MockHomeService extends Mock implements HomeService {}

class MockSnackBarService extends Mock implements SnackBarService {}

void main() {
  group('Check QR code invite middleware tests', () {
    late TestStore<AppState> store;
    late HomeService homeService;
    late SnackBarService snackBarService;
    late CheckInviteMiddleware middleware;

    setUp(() {
      homeService = MockHomeService();
      snackBarService = MockSnackBarService();

      middleware = CheckInviteMiddleware(homeService, snackBarService);

      store = TestStore<AppState>(
        appReducer,
        initialState: AppState.initial(),
        middleware: [middleware],
      );
    });

    test('''on invalid QR code invite show error and finish check''', () async {
      const inviteUrl = 'invite url';
      when(() => homeService.homeByInviteUrl(inviteUrl))
          .thenAnswer((_) => Future.value());

      await middleware.process(store, CheckInviteAction(invite: inviteUrl));

      verify(() => homeService.homeByInviteUrl(inviteUrl)).called(1);
      verify(() => snackBarService.showInvalidInviteError()).called(1);
      expect(store.actionLog.length, 1);
      expect(store.actionLog[0], const TypeMatcher<InviteCheckedAction>());
    });

    test('''on valid invite show join home''', () async {
      const inviteUrl = 'invite url';

      const homeToJoin = Home(
        id: 'id',
        homeName: 'homeName',
        adminId: 'adminId',
        usersIds: ['usersIds'],
        address: 'address',
        about: 'about',
        avatarUrl: 'avatarUrl',
      );

      when(() => homeService.homeByInviteUrl(inviteUrl))
          .thenAnswer((_) => Future.value(homeToJoin));

      await middleware.process(store, CheckInviteAction(invite: inviteUrl));

      verify(() => homeService.homeByInviteUrl(inviteUrl)).called(1);
      verifyZeroInteractions(snackBarService);
      expect(store.actionLog.length, 3);
      expect(store.actionLog[0], const TypeMatcher<InitJoinHomeAction>());
      expect(store.actionLog[0].homeToJoin, homeToJoin);
      expect(store.actionLog[1], ReplaceNavigationAction(JoinHomeRoute()));
      expect(store.actionLog[2], const TypeMatcher<InviteCheckedAction>());
    });

    test('''on request failed show error''', () async {
      const inviteUrl = 'invite url';
      when(() => homeService.homeByInviteUrl(inviteUrl))
          .thenThrow(const NetworkError.unknown());

      await middleware.process(store, CheckInviteAction(invite: inviteUrl));

      verify(() => homeService.homeByInviteUrl(inviteUrl)).called(1);
      verify(() => snackBarService.showCommonError()).called(1);
      expect(store.actionLog.length, 1);
      expect(store.actionLog[0], const TypeMatcher<InviteCheckedAction>());
    });
  });
}
