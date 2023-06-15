import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';

part 'leave_home_dialog_view_model.freezed.dart';

@Freezed(copyWith: false)
class LeaveHomeDialogViewModel with _$LeaveHomeDialogViewModel {
  const factory LeaveHomeDialogViewModel.user({
    required Command onLeaveHome,
    required Command onCancel,
  }) = _User;

  const factory LeaveHomeDialogViewModel.admin({
    required String newAdminName,
    required Command onLeaveHome,
    required Command onCancel,
  }) = _Admin;

  const factory LeaveHomeDialogViewModel.adminWithUsers({
    required List<SelectAdminViewModel> users,
    required Command? onLeaveHome,
    required Command onCancel,
  }) = _AdminWithUsers;
}

@Freezed(copyWith: false)
class SelectAdminViewModel with _$SelectAdminViewModel {
  const factory SelectAdminViewModel({
    required String? userPictureUrl,
    required String userName,
    required Command? onSelectAdmin,
  }) = _SelectAdminViewModel;
}
