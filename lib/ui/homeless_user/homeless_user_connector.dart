import 'package:flutter/material.dart';
import 'package:nestify/redux/app_state.dart';
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
      onCreateHome: Command.stub,
      onScanQrCode: Command.stub,
    );
  }

  @override
  Widget screen(HomelessUserViewModel viewModel) =>
      HomelessUserScreen(viewModel: viewModel);
}
