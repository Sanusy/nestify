import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/my_profile/my_profile_action.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/common/avatar_picker/avatar_picker_view_model.dart';
import 'package:nestify/ui/common/color_selector/color_selector_item_view_model.dart';
import 'package:nestify/ui/common/text_field/nestify_text_field_view_model.dart';
import 'package:nestify/ui/my_profile/my_profile_screen.dart';
import 'package:nestify/ui/my_profile/my_profile_view_model.dart';
import 'package:redux/redux.dart';

final class MyProfileConnector extends BaseConnector<MyProfileViewModel> {
  const MyProfileConnector({super.key});

  @override
  void onInit(Store<AppState> store) {
    store.dispatch(
      InitMyProfileAction(
        store.state.homeState.homeUsers.firstWhere(
            (homeUser) => store.state.homeState.currentUserId == homeUser.id),
      ),
    );
  }

  @override
  void onDispose(Store<AppState> store) {
    store.dispatch(CloseMyProfileAction());
  }

  @override
  MyProfileViewModel convert(
    BuildContext context,
    Store<AppState> store,
  ) {
    final myProfileState = store.state.myProfileState;
    final homeState = store.state.homeState;

    if (myProfileState.isLoading || myProfileState.editedProfile == null) {
      return const MyProfileViewModel.loading();
    }

    final editedProfile = myProfileState.editedProfile;
    final localization = AppLocalizations.of(context)!;

    return MyProfileViewModel.body(
      quitConfirmation: myProfileState.hasChanges
          ? store.baseQuitConfirmationViewModel
          : null,
      onSave: myProfileState.hasChanges && myProfileState.canEditMyProfile
          ? store.createCommand(EditMyProfileAction())
          : null,
      userAvatarViewModel: myProfileState.editedProfile?.avatarUrl == null
          ? AvatarPickerViewModel.file(
              picture: myProfileState.pickedAvatar,
              onClick: store.createCommand(
                myProfileState.pickedAvatar == null
                    ? MyProfilePickAvatarAction()
                    : RemoveMyProfileAvatarAction(),
              ),
            )
          : AvatarPickerViewModel.url(
              picture: editedProfile!.avatarUrl!,
              onClick: store.createCommand(
                RemoveMyProfileAvatarAction(),
              ),
            ),
      userNameViewModel: NestifyTextFieldViewModel(
        text: editedProfile!.userName,
        onTextChanged: store.createCommandWith(
          (newName) => MyProfileNameChangedAction(newName),
        ),
        errorText: editedProfile.userName.isEmpty
            ? localization.myProfileNameError
            : null,
      ),
      userBioViewModel: NestifyTextFieldViewModel(
        text: editedProfile.bio,
        onTextChanged: store.createCommandWith(
          (newAddress) => MyProfileBioChangedAction(newAddress),
        ),
      ),
      availableColors: homeState.colors.map((color) {
        final isEnabled = !homeState.homeUsers.any((user) =>
            user.id != homeState.currentUserId && user.colorId == color.id);
        return ColorSelectorItemViewModel(
          onSelect: editedProfile.colorId == color.id
              ? null
              : store.createCommand(MyProfileColorChangedAction(color)),
          isEnabled: isEnabled,
          color: color.toColor,
        );
      }).toList()
        ..sort(ColorSelectorItemViewModel.colorSorting),
    );
  }

  @override
  Widget screen(MyProfileViewModel viewModel) =>
      MyProfileScreen(viewModel: viewModel);
}
