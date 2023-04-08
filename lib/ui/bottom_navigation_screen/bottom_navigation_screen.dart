import 'package:flutter/material.dart';
import 'package:nestify/ui/bottom_navigation_screen/bottom_navigation_destinations.dart';
import 'package:nestify/ui/bottom_navigation_screen/bottom_navigation_view_model.dart';

class BottomNavigationScreen extends StatefulWidget {
  final BottomNavigationViewModel viewModel;

  const BottomNavigationScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  BottomNavigationDestination currentDestination =
      BottomNavigationDestination.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.viewModel.currentScreen,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (selectedDestinationIndex) {
          setState(() {
            currentDestination =
                BottomNavigationDestination.values[selectedDestinationIndex];
            widget.viewModel.onSelectDestination(
              currentDestination,
            );
          });
        },
        selectedIndex: currentDestination.index,
        destinations: BottomNavigationDestination.values
            .map((destination) => destination.destination(context))
            .toList(),
      ),
    );
  }
}
