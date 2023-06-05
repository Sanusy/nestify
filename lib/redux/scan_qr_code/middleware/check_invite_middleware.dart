import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/common_middlewares/base_middleware.dart';
import 'package:nestify/redux/join_home/join_home_action.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/redux/scan_qr_code/scan_qr_code_action.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:nestify/service/snack_bar_service/snack_bar_service.dart';
import 'package:redux/redux.dart';

final class CheckInviteMiddleware extends BaseMiddleware<CheckInviteAction> {
  final HomeService _homeService;
  final SnackBarService _snackBarService;

  CheckInviteMiddleware(
    this._homeService,
    this._snackBarService,
  );

  @override
  Future<void> process(
    Store<AppState> store,
    CheckInviteAction action,
  ) async {
    try {
      final homeToJoin = await _homeService.homeByInviteUrl(action.invite);
      if (homeToJoin == null) {
        _snackBarService.showInvalidInviteError();
      } else {
        store.dispatch(InitJoinHomeAction(homeToJoin: homeToJoin));
        store.dispatch(ReplaceNavigationAction(JoinHomeRoute()));
      }
    } on NetworkError {
      _snackBarService.showCommonError();
    } finally {
      store.dispatch(InviteCheckedAction());
    }
  }
}
