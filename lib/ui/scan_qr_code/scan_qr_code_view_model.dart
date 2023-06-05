import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';

part 'scan_qr_code_view_model.freezed.dart';

@Freezed(copyWith: false)
class ScanQrCodeViewModel with _$ScanQrCodeViewModel {
  const factory ScanQrCodeViewModel({
    required CommandWith<String>? onCheckInvite,
  }) = _ScanQrCodeViewModel;
}
