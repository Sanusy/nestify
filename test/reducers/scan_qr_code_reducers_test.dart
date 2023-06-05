import 'package:flutter_test/flutter_test.dart';
import 'package:nestify/redux/app_reducer.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/scan_qr_code/scan_qr_code_action.dart';
import 'package:redux/redux.dart';

void main() {
  group('Scan QR code reducers test group', () {
    late Store<AppState> store;

    setUp(() {
      store = Store<AppState>(appReducer, initialState: AppState.initial());
    });

    test('is checking flag is true on check QR code start', () {
      store.dispatch(CheckInviteAction(invite: 'invite'));

      expect(store.state.scanQrCodeState.isCheckingInvite, isTrue);
    });

    test('is checking flag is false after check QR code end', () {
      store.dispatch(InviteCheckedAction());

      expect(store.state.scanQrCodeState.isCheckingInvite, isFalse);
    });
  });
}
