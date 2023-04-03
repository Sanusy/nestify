import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/create_home/create_home_view_model.dart';
import 'package:nestify/ui/create_home/home_profile_step/home_profile_step_view.dart';
import 'package:nestify/ui/create_home/user_profile_step/user_profile_step_view.dart';

class CreateHomeScreen extends StatelessWidget {
  final CreateHomeViewModel viewModel;

  const CreateHomeScreen({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          viewModel.createHomeStepViewModel.map(
            homeProfile: (_) => localization.createHomeHomeProfileTabTitle,
            userProfile: (_) => localization.createHomeUserProfileTabTitle,
          ),
        ),
      ),
      // TODO: Probably implement Stepper here to be clear what is going on each step
      body: SafeArea(
        child: viewModel.createHomeStepViewModel.map(
          homeProfile: (createHomeProfileViewModel) =>
              CreateHomeProfileStepView(viewModel: createHomeProfileViewModel),
          userProfile: (createUserProfileStepViewModel) =>
              CreateUserProfileStepView(
            viewModel: createUserProfileStepViewModel,
          ),
        ),
      ),
    );
  }
}
