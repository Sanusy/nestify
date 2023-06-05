import 'package:flutter/material.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/scan_qr_code/scan_qr_code_action.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/scan_qr_code/scan_qr_code_screen.dart';
import 'package:nestify/ui/scan_qr_code/scan_qr_code_view_model.dart';
import 'package:redux/redux.dart';

final class ScanQrCodeConnector extends BaseConnector<ScanQrCodeViewModel> {
  const ScanQrCodeConnector({super.key});

  @override
  ScanQrCodeViewModel convert(
    BuildContext context,
    Store<AppState> store,
  ) {
    return ScanQrCodeViewModel(
      onCheckInvite: store.state.scanQrCodeState.isCheckingInvite
          ? null
          : store.createCommandWith(
              (invite) => CheckInviteAction(invite: invite),
            ),
    );
  }

  @override
  Widget screen(ScanQrCodeViewModel viewModel) =>
      ScanQrCodeScreen(viewModel: viewModel);
}
