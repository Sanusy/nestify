import 'package:flutter/material.dart';
import 'package:nestify/ui/scan_qr_code/scan_qr_code_view_model.dart';

class ScanQrCodeScreen extends StatelessWidget {
  final ScanQrCodeViewModel viewModel;

  const ScanQrCodeScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Scan QR code'),
      ),
    );
  }
}
