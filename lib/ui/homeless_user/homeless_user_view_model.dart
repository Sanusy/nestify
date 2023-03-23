import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';

part 'homeless_user_view_model.freezed.dart';

@Freezed(copyWith: false)
class HomelessUserViewModel with _$HomelessUserViewModel {
  const factory HomelessUserViewModel({
    required Command? onCreateHome,
    required Command? onScanQrCode,
    required Command? onLogout,
    required bool isLoading,
    required HomelessUserEvent? event,
  }) = _HomelessUserViewModel;
}

@Freezed(copyWith: false)
class HomelessUserEvent with _$HomelessUserEvent {
  const factory HomelessUserEvent.failedToCreateHomeDraft({
    required Command onProcessed,
  }) = _HomelessUserEvent;
}
