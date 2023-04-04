import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/common/avatar_picker/avatar_picker_view_model.dart';
import 'package:nestify/ui/common/quit_confirmation_dialog/quit_confirmation_dialog_view_model.dart';
import 'package:nestify/ui/common/text_field/nestify_text_field_view_model.dart';
import 'package:nestify/ui/create_home/user_profile_step/create_home_color_selector/create_home_color_selector_view_model.dart';

part 'create_home_view_model.freezed.dart';

@Freezed(copyWith: false)
class CreateHomeViewModel with _$CreateHomeViewModel {
  const factory CreateHomeViewModel({
    required QuitConfirmationDialogViewModel? quitConfirmation,
    required CreateHomeStepViewModel createHomeStepViewModel,
    required CreateHomeEvent? event,
  }) = _CreateHomeViewModel;
}

@Freezed(copyWith: false)
class CreateHomeStepViewModel with _$CreateHomeStepViewModel {
  const factory CreateHomeStepViewModel.homeProfile({
    required AvatarPickerViewModel homeAvatarViewModel,
    required NestifyTextFieldViewModel homeNameViewModel,
    required NestifyTextFieldViewModel homeAddressViewModel,
    required NestifyTextFieldViewModel homeAboutViewModel,
    required Command? onNext,
  }) = CreateHomeProfileStepViewModel;

  const factory CreateHomeStepViewModel.userProfile({
    required AvatarPickerViewModel userAvatarViewModel,
    required NestifyTextFieldViewModel userNameViewModel,
    required NestifyTextFieldViewModel userBioViewModel,
    required CreateHomeColorSelectorViewModel colorSelectorViewModel,
    required bool isLoading,
    required Command? onBack,
    required Command? onCreate,
  }) = CreateUserProfileStepViewModel;
}

@Freezed(copyWith: false)
class CreateHomeEvent with _$CreateHomeEvent {
  const factory CreateHomeEvent.failedToObtainPhoto({
    required Command onProcessed,
  }) = _FailedToObtainPhoto;

  const factory CreateHomeEvent.failedToCreateHome({
    required Command onProcessed,
  }) = _FailedToCreateHome;
}
