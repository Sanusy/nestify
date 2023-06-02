import 'package:freezed_annotation/freezed_annotation.dart';

part 'scan_qr_code_view_model.freezed.dart';

@Freezed(copyWith: false)
class ScanQrCodeViewModel with _$ScanQrCodeViewModel {
  const factory ScanQrCodeViewModel({
    required String stub,
  }) = _ScanQrCodeViewModel;
}
