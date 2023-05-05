import 'package:flutter/material.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/join_home/join_home_screen.dart';
import 'package:nestify/ui/join_home/join_home_view_model.dart';
import 'package:redux/redux.dart';

class JoinHomeConnector extends BaseConnector<JoinHomeViewModel> {
  const JoinHomeConnector({super.key});

  @override
  JoinHomeViewModel convert(BuildContext context, Store<AppState> store) {
    return JoinHomeViewModel(
      onJoin: Command.stub,
    );
  }

  @override
  Widget screen(JoinHomeViewModel viewModel) =>
      JoinHomeScreen(viewModel: viewModel);
}
