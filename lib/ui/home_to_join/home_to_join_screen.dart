import 'package:flutter/material.dart';
import 'package:nestify/ui/home_to_join/home_to_join_view_model.dart';

class HomeToJoinScreen extends StatelessWidget {
  final HomeToJoinViewModel viewModel;

  const HomeToJoinScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home to Join'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home to join screen'),
          ],
        ),
      ),
    );
  }
}
