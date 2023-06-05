import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/scan_qr_code/components/qr_code_scanner_view/qr_code_scanner_view.dart';
import 'package:nestify/ui/scan_qr_code/scan_qr_code_view_model.dart';

class ScanQrCodeScreen extends StatelessWidget {
  final ScanQrCodeViewModel viewModel;

  const ScanQrCodeScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          localization.scanQrCodeTitle,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: QrCodeScannerView(
        onCheckInvite: viewModel.onCheckInvite,
      ),
    );
  }
}
