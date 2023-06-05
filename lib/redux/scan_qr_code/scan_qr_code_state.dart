import 'package:freezed_annotation/freezed_annotation.dart';

part 'scan_qr_code_state.freezed.dart';

@freezed
class ScanQrCodeState with _$ScanQrCodeState {
  const factory ScanQrCodeState({
    required bool isCheckingInvite,
  }) = _ScanQrCodeState;

  factory ScanQrCodeState.initial() => const ScanQrCodeState(
        isCheckingInvite: false,
      );
}
