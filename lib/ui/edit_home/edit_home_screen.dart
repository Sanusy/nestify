import 'package:flutter/material.dart';
import 'package:nestify/ui/edit_home/edit_home_view_model.dart';

class EditHomeScreen extends StatelessWidget {
  final EditHomeViewModel viewModel;

  const EditHomeScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Edit Home screen'),
          ],
        ),
      ),
    );
  }
}
