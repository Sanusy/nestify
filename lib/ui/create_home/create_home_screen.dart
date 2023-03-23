import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/create_home/create_home_view_model.dart';

class CreateHomeScreen extends StatelessWidget {
  final CreateHomeViewModel viewModel;

  const CreateHomeScreen({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Text('Create home'),
      ),
    );
  }
}
