import 'package:flutter/material.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/bottom_navigation_screen/bottom_navigation_destinations.dart';
import 'package:nestify/ui/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:nestify/ui/bottom_navigation_screen/bottom_navigation_view_model.dart';
import 'package:nestify/ui/command.dart';
import 'package:redux/redux.dart';

class BottomNavigationConnector
    extends BaseConnector<BottomNavigationViewModel> {
  final Widget currentScreen;

  const BottomNavigationConnector({
    super.key,
    required this.currentScreen,
  });

  @override
  BottomNavigationViewModel convert(
    BuildContext context,
    Store<AppState> store,
  ) {
    return BottomNavigationViewModel(
      currentScreen: currentScreen,
      onSelectDestination: CommandWith((selectedDestination) {
        store.dispatch(NavigationAction.setPath(selectedDestination.route));
      }),
    );
  }

  @override
  Widget screen(BottomNavigationViewModel viewModel) => BottomNavigationScreen(
        viewModel: viewModel,
      );
}
