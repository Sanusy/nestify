import 'package:flutter/material.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/home_to_join/home_to_join_screen.dart';
import 'package:nestify/ui/home_to_join/home_to_join_view_model.dart';
import 'package:redux/redux.dart';

class HomeToJoinConnector extends BaseConnector<HomeToJoinViewModel> {
  const HomeToJoinConnector({super.key});

  @override
  HomeToJoinViewModel convert(BuildContext context, Store<AppState> store) {
    return HomeToJoinViewModel(
      onJoin: Command.stub,
    );
  }

  @override
  Widget screen(HomeToJoinViewModel viewModel) =>
      HomeToJoinScreen(viewModel: viewModel);
}
