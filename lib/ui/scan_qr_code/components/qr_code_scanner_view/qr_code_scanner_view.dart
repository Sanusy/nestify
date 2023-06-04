import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nestify/ui/scan_qr_code/components/qr_code_scanner_view/qr_code_camera_overlay_paint.dart';

class QrCodeScannerView extends StatefulWidget {
  const QrCodeScannerView({super.key});

  @override
  State<QrCodeScannerView> createState() => _QrCodeScannerViewState();
}

class _QrCodeScannerViewState extends State<QrCodeScannerView> {
  late MobileScannerController _controller;

  @override
  void initState() {
    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    final screenSize = MediaQuery.sizeOf(context);
    final previewSize = screenSize.width - (80 * 2);
    final qrCodeRect = Rect.fromCenter(
      center: Offset(screenSize.width / 2, screenSize.height / 2),
      width: previewSize,
      height: previewSize,
    );

    return CustomPaint(
      foregroundPainter: QrCodeCameraOverlayPaint(
        qrCodeRect: qrCodeRect,
        scanQrCodeHint: localization.scanQrCodeHint,
      ),
      child: MobileScanner(
        placeholderBuilder: (_, __) {
          /// Here to give a CustomPaint widget size of the screen while camera is initializing.
          return SizedBox(
            width: screenSize.width,
            height: screenSize.height,
          );
        },
        scanWindow: qrCodeRect,
        controller: _controller,
        onDetect: (BarcodeCapture barcodes) {
          for (final barcode in barcodes.barcodes) {
            debugPrint('👹 ${barcode.rawValue}');
          }
        },
      ),
    );
  }
}
