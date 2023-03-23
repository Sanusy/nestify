import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/common/avatar_picker/avatar_picker_view_model.dart';
import 'package:nestify/ui/common/text_field/nestify_text_field_view_model.dart';

part 'create_home_view_model.freezed.dart';

@Freezed(copyWith: false)
class CreateHomeViewModel with _$CreateHomeViewModel {
  const factory CreateHomeViewModel({
    required Command onDiscard,
    required Command onLogout,
    required AvatarPickerViewModel homeAvatarViewModel,
    required NestifyTextFieldViewModel homeNameViewModel,
    required NestifyTextFieldViewModel homeAddressViewModel,
    required NestifyTextFieldViewModel homeAboutViewModel,
    required Command? onCreateHome,
    required bool isLoading,
    required CreateHomeEvent? event,
  }) = _CreateHomeViewModel;
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
