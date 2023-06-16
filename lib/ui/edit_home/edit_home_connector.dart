import 'package:flutter/material.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
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
    );
  }

  @override
  Widget screen(EditHomeViewModel viewModel) =>
      EditHomeScreen(viewModel: viewModel);
}
