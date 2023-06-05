import 'package:nestify/redux/scan_qr_code/scan_qr_code_action.dart';
import 'package:nestify/redux/scan_qr_code/scan_qr_code_state.dart';
import 'package:redux/redux.dart';

final scanQrCodeStateStateReducer = combineReducers<ScanQrCodeState>([
  TypedReducer(_checkInvite),
  TypedReducer(_inviteChecked),
]);

ScanQrCodeState _checkInvite(
  ScanQrCodeState state,
  CheckInviteAction action,
) {
  return state.copyWith(
    isCheckingInvite: true,
  );
}

ScanQrCodeState _inviteChecked(
  ScanQrCodeState state,
  InviteCheckedAction action,
) {
  return state.copyWith(
    isCheckingInvite: false,
  );
}
