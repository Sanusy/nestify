import 'package:flutter/material.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/login/login_action.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/create_user_profile/create_user_profile_screen.dart';
import 'package:nestify/ui/create_user_profile/create_user_profile_view_model.dart';
import 'package:redux/redux.dart';

class CreateUserProfileConnector
    extends BaseConnector<CreateUserProfileViewModel> {
  const CreateUserProfileConnector({super.key});

  @override
  CreateUserProfileViewModel convert(
      BuildContext context, Store<AppState> store) {
    return CreateUserProfileViewModel(
      onLogout: store.createCommand(
        LogoutAction(),
      ),
    );
  }

  @override
  Widget screen(CreateUserProfileViewModel viewModel) =>
      CreateUserProfileScreen(viewModel: viewModel);
}
