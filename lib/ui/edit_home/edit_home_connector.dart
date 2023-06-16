import 'package:flutter/material.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/common/avatar_picker/avatar_picker_view_model.dart';
import 'package:nestify/ui/common/text_field/nestify_text_field_view_model.dart';
import 'package:nestify/ui/edit_home/edit_home_screen.dart';
import 'package:nestify/ui/edit_home/edit_home_view_model.dart';
import 'package:redux/redux.dart';

final class EditHomeConnector extends BaseConnector<EditHomeViewModel> {
  const EditHomeConnector({super.key});

  @override
  EditHomeViewModel convert(
    BuildContext context,
    Store<AppState> store,
  ) {
    return EditHomeViewModel(
      onEdit: Command.stub,
      homeAvatarViewModel: AvatarPickerViewModel.file(
        picture: null,
        onClick: Command.stub,
      ),
      homeNameViewModel: NestifyTextFieldViewModel(
        text: '',
        onTextChanged: CommandWith((_) {}),
      ),
      homeAddressViewModel: NestifyTextFieldViewModel(
        text: '',
        onTextChanged: CommandWith((_) {}),
      ),
      homeAboutViewModel: NestifyTextFieldViewModel(
        text: '',
        onTextChanged: CommandWith((_) {}),
      ),
    );
  }

  @override
  Widget screen(EditHomeViewModel viewModel) =>
      EditHomeScreen(viewModel: viewModel);
}
