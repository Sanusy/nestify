import 'package:flutter/material.dart';
import 'package:nestify/ui/bottom_navigation_screen/bottom_navigation_destinations.dart';
import 'package:nestify/ui/bottom_navigation_screen/bottom_navigation_view_model.dart';

class BottomNavigationScreen extends StatelessWidget {
  final BottomNavigationViewModel viewModel;

  const BottomNavigationScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: viewModel.currentScreen,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (selectedDestinationIndex) {
          viewModel.onSelectDestination(
            BottomNavigationDestination.values[selectedDestinationIndex],
          );
        },
        selectedIndex: viewModel.currentDestination.index,
        destinations: BottomNavigationDestination.values
            .map((destination) => destination.destination(context))
            .toList(),
      ),
    );
  }
}
