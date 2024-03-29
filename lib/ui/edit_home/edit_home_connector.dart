import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/edit_home/edit_home_action.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/common/avatar_picker/avatar_picker_view_model.dart';
import 'package:nestify/ui/common/text_field/nestify_text_field_view_model.dart';
import 'package:nestify/ui/edit_home/edit_home_screen.dart';
import 'package:nestify/ui/edit_home/edit_home_view_model.dart';
import 'package:redux/redux.dart';

final class EditHomeConnector extends BaseConnector<EditHomeViewModel> {
  @override
  void onInit(Store<AppState> store) {
    store.dispatch(InitEditHomeAction(store.state.homeState.home!));
    super.onInit(store);
  }

  @override
  void onDispose(Store<AppState> store) {
    store.dispatch(CloseEditHomeAction());
    super.onDispose(store);
  }

  const EditHomeConnector({super.key});

  @override
  EditHomeViewModel convert(
    BuildContext context,
    Store<AppState> store,
  ) {
    final editHomeState = store.state.editHomeState;

    if (editHomeState.isLoading) {
      return const EditHomeViewModel.loading();
    }

    final editedHome = editHomeState.editedHome!;
    final localization = AppLocalizations.of(context)!;

    return EditHomeViewModel.loaded(
      quitConfirmation:
          editHomeState.hasChanges ? store.baseQuitConfirmationViewModel : null,
      onEdit: editHomeState.hasChanges && editHomeState.canEditHome
          ? store.createCommand(EditHomeAction())
          : null,
      homeAvatarViewModel: editedHome.avatarUrl == null
          ? AvatarPickerViewModel.file(
              picture: editHomeState.pickedAvatar,
              onClick: store.createCommand(
                editHomeState.pickedAvatar == null
                    ? EditHomePickHomeAvatarAction()
                    : RemoveEditHomeAvatarAction(),
              ),
            )
          : AvatarPickerViewModel.url(
              picture: editedHome.avatarUrl!,
              onClick: store.createCommand(
                RemoveEditHomeAvatarAction(),
              ),
            ),
      homeNameViewModel: NestifyTextFieldViewModel(
        text: editedHome.homeName,
        onTextChanged: store.createCommandWith(
          (newName) => EditHomeNameChangedAction(newName),
        ),
        errorText: editedHome.homeName.isEmpty
            ? localization.editHomeEmptyNameError
            : null,
      ),
      homeAddressViewModel: NestifyTextFieldViewModel(
        text: editedHome.address,
        onTextChanged: store.createCommandWith(
          (newAddress) => EditHomeAddressChangedAction(newAddress),
        ),
      ),
      homeAboutViewModel: NestifyTextFieldViewModel(
        text: editedHome.about,
        onTextChanged: store.createCommandWith(
          (newAbout) => EditHomeAboutChangedAction(newAbout),
        ),
      ),
    );
  }

  @override
  Widget screen(EditHomeViewModel viewModel) =>
      EditHomeScreen(viewModel: viewModel);
}
