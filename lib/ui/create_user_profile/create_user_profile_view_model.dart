import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/common/avatar_picker/avatar_picker_view_model.dart';
import 'package:nestify/ui/common/text_field/nestify_text_field_view_model.dart';

part 'create_user_profile_view_model.freezed.dart';

@Freezed(copyWith: false)
class CreateUserProfileViewModel with _$CreateUserProfileViewModel {
  const factory CreateUserProfileViewModel({
    required Command onLogout,
    required Command onDiscard,
    required AvatarPickerViewModel userAvatarViewModel,
    required NestifyTextFieldViewModel nameViewModel,
    required NestifyTextFieldViewModel bioViewModel,
    required bool isLoading,
    required Command? onSaveProfile,
  }) = _CreateUserProfileViewModel;
}
