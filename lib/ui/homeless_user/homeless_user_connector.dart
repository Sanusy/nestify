import 'package:flutter/material.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/homeless_user/homeless_user_action.dart';
import 'package:nestify/redux/login/login_action.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/homeless_user/homeless_user_screen.dart';
import 'package:nestify/ui/homeless_user/homeless_user_view_model.dart';
import 'package:redux/redux.dart';

class HomelessUserConnector extends BaseConnector<HomelessUserViewModel> {
  const HomelessUserConnector({super.key});

  @override
  HomelessUserViewModel convert(BuildContext context, Store<AppState> store) {
    return HomelessUserViewModel(
      onCreateHome: store.createCommand(OnCreateHomeAction()),
      onScanQrCode: Command.stub,
      onLogout: store.createCommand(LogoutAction()),
    );
  }

  @override
  Widget screen(HomelessUserViewModel viewModel) =>
      HomelessUserScreen(viewModel: viewModel);
}
