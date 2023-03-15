import 'package:flutter/material.dart';
import 'package:nestify/ui/homeless_user/homeless_user_view_model.dart';

class HomelessUserScreen extends StatelessWidget {
  final HomelessUserViewModel viewModel;

  const HomelessUserScreen({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('homeless user screen'),
      ),
    );
  }
}
