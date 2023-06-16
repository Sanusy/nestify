import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/common/avatar_picker/avatar_picker_view_model.dart';
import 'package:nestify/ui/common/text_field/nestify_text_field_view_model.dart';

part 'edit_home_view_model.freezed.dart';

@Freezed(copyWith: false)
class EditHomeViewModel with _$EditHomeViewModel {
  const factory EditHomeViewModel({
    required Command? onEdit,
    required AvatarPickerViewModel homeAvatarViewModel,
    required NestifyTextFieldViewModel homeNameViewModel,
    required NestifyTextFieldViewModel homeAddressViewModel,
    required NestifyTextFieldViewModel homeAboutViewModel,
  }) = _EditHomeViewModel;
}
