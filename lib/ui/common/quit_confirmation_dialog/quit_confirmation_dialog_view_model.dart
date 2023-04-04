import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';

part 'quit_confirmation_dialog_view_model.freezed.dart';

@Freezed(copyWith: false)
class QuitConfirmationDialogViewModel with _$QuitConfirmationDialogViewModel {
  const factory QuitConfirmationDialogViewModel({
    required Command onQuit,
    required Command onStay,
  }) = _QuitConfirmationDialogViewModel;
}
