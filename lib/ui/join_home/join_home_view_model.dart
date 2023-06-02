import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/common/avatar_picker/avatar_picker_view_model.dart';
import 'package:nestify/ui/common/color_selector/color_selector_item_view_model.dart';
import 'package:nestify/ui/common/quit_confirmation_dialog/quit_confirmation_dialog_view_model.dart';
import 'package:nestify/ui/common/text_field/nestify_text_field_view_model.dart';
import 'package:nestify/ui/common/user_tile_view/user_tile_view_model.dart';

part 'join_home_view_model.freezed.dart';

@Freezed(copyWith: false)
class JoinHomeViewModel with _$JoinHomeViewModel {
  const factory JoinHomeViewModel.loading() = _JoinHomeLoading;

  const factory JoinHomeViewModel.error({
    required Command onRetry,
  }) = _JoinHomeError;

  const factory JoinHomeViewModel.homeDetails({
    required String? pictureUrl,
    required String homeName,
    required String? homeAddress,
    required String? about,
    required List<UserTileViewModel> users,
    required Command onNext,
  }) = JoinHomeDetailsViewModel;

  const factory JoinHomeViewModel.userProfile({
    required QuitConfirmationDialogViewModel? quitConfirmation,
    required AvatarPickerViewModel userAvatarViewModel,
    required NestifyTextFieldViewModel userNameViewModel,
    required NestifyTextFieldViewModel userBioViewModel,
    required List<ColorSelectorItemViewModel> availableColors,
    required bool isLoading,
    required Command? onJoin,
  }) = JoinHomeUserProfileViewModel;
}
