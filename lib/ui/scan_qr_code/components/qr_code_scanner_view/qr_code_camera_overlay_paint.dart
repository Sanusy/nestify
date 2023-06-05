import 'package:flutter/material.dart';

class QrCodeCameraOverlayPaint extends CustomPainter {
  final Rect qrCodeRect;
  final String scanQrCodeHint;

  const QrCodeCameraOverlayPaint({
    required this.qrCodeRect,
    required this.scanQrCodeHint,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final qrCodeTopBorder = centerY - (qrCodeRect.height / 2);
    final qrCodeBottomBorder = centerY + (qrCodeRect.height / 2);
    final qrCodeLeftBorder = centerX - (qrCodeRect.width / 2);
    final qrCodeRightBorder = centerX + (qrCodeRect.width / 2);

    final topRect = Rect.fromLTRB(
      0,
      0,
      size.width,
      qrCodeTopBorder,
    );

    final bottomRect = Rect.fromLTRB(
      0,
      qrCodeBottomBorder,
      size.width,
      size.height,
    );

    final leftRect = Rect.fromLTRB(
      0,
      qrCodeTopBorder,
      qrCodeLeftBorder,
      qrCodeBottomBorder,
    );

    final rightRect = Rect.fromLTRB(
      qrCodeRightBorder,
      qrCodeTopBorder,
      size.width,
      qrCodeBottomBorder,
    );

    final overlayPaint = Paint()..color = Colors.black.withOpacity(0.5);

    canvas.drawRect(topRect, overlayPaint);
    canvas.drawRect(bottomRect, overlayPaint);
    canvas.drawRect(leftRect, overlayPaint);
    canvas.drawRect(rightRect, overlayPaint);

    final cornerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(centerX, centerY),
          width: qrCodeRect.width + 2,
          height: qrCodeRect.height + 2,
        ),
        const Radius.circular(8),
      ),
      cornerPaint,
    );

    const textStyle = TextStyle();
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: scanQrCodeHint, style: textStyle),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: size.width - 32);

    textPainter.paint(
      canvas,
      Offset(
        centerX - textPainter.width / 2,
        qrCodeBottomBorder + 64,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
