import 'package:flutter/material.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/middleware/common_actions.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/home/home_screen.dart';
import 'package:nestify/ui/home/home_view_model.dart';
import 'package:redux/redux.dart';

class HomeConnector extends BaseConnector<HomeViewModel> {
  const HomeConnector({super.key});

  @override
  HomeViewModel convert(BuildContext context, Store<AppState> store) {
    return HomeViewModel(
      onLogout: store.createCommand(LogoutAction()),
    );
  }

  @override
  Widget screen(HomeViewModel viewModel) => HomeScreen(viewModel: viewModel);
}
