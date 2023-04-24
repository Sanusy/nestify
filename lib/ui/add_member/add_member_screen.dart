import 'package:flutter/material.dart';
import 'package:nestify/ui/add_member/add_member_view_model.dart';

class AddMemberScreen extends StatelessWidget {
  final AddMemberViewModel viewModel;

  const AddMemberScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add member'),
      ),
      body: const Center(
        child: Text('Add member'),
      ),
    );
  }
}
