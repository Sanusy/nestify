import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/common_middlewares/base_middleware.dart';
import 'package:nestify/redux/scan_qr_code/scan_qr_code_action.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:redux/redux.dart';

final class CheckInviteMiddleware extends BaseMiddleware<CheckInviteAction> {
  final HomeService _homeService;

  CheckInviteMiddleware(
    this._homeService,
  );

  @override
  Future<void> process(
    Store<AppState> store,
    CheckInviteAction action,
  ) async {
    try {} on NetworkError {}
  }
}
