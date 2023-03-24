import 'package:flutter/material.dart';
import 'package:nestify/ui/create_user_profile/create_user_profile_view_model.dart';

class CreateUserProfileScreen extends StatelessWidget {
  final CreateUserProfileViewModel viewModel;

  const CreateUserProfileScreen({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create user profile'),
      ),
      body: Center(
        child: OutlinedButton(
          onPressed: viewModel.onLogout,
          child: Text('Comming soon (Logout)'),
        ),
      ),
    );
  }
}
