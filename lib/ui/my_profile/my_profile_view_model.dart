import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/common/avatar_picker/avatar_picker_view_model.dart';
import 'package:nestify/ui/common/quit_confirmation_dialog/quit_confirmation_dialog_view_model.dart';
import 'package:nestify/ui/common/text_field/nestify_text_field_view_model.dart';

part 'my_profile_view_model.freezed.dart';

@Freezed(copyWith: false)
sealed class MyProfileViewModel with _$MyProfileViewModel {
  const factory MyProfileViewModel.loading() = LoadingMyProfileViewModel;

  const factory MyProfileViewModel.body({
    required QuitConfirmationDialogViewModel? quitConfirmation,
    required Command? onSave,
    required AvatarPickerViewModel userAvatarViewModel,
    required NestifyTextFieldViewModel userNameViewModel,
    required NestifyTextFieldViewModel userBioViewModel,
  }) = MyProfileBodyViewModel;
}
