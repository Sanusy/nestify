import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';

part 'homeless_user_view_model.freezed.dart';

@Freezed(copyWith: false)
abstract class HomelessUserViewModel with _$HomelessUserViewModel {
  const factory HomelessUserViewModel({
    required Command onCreateHome,
    required Command onScanQrCode,
    required Command onLogout,
  }) = _HomelessUserViewModel;
}
