import 'package:flutter/material.dart';
import 'package:nestify/ui/join_home/join_home_view_model.dart';

class JoinHomeScreen extends StatelessWidget {
  final JoinHomeViewModel viewModel;

  const JoinHomeScreen({
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
