import 'package:flutter/material.dart';
import 'package:nestify/ui/home/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel viewModel;

  const HomeScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home screen'),
            OutlinedButton(
              onPressed: viewModel.onLogout,
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
