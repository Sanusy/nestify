import 'package:flutter/material.dart';
import 'package:nestify/ui/scan_qr_code/scan_qr_code_view_model.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

class ScanQrCodeScreen extends StatelessWidget {
  final ScanQrCodeViewModel viewModel;

  const ScanQrCodeScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: QRCodeDartScanView(),
    );
  }
}
