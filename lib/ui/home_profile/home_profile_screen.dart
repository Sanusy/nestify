import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/home_profile/home_profile_view_model.dart';

class HomeProfileScreen extends StatelessWidget {
  final HomeProfileViewModel viewModel;

  const HomeProfileScreen({Key? key, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.homeProfileTitle),
      ),
      body: viewModel.map(
        loading: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
        failed: (failedViewModel) => const Center(
          child: Text('Failed'),
        ),
        loaded: (loadedViewModel) {
          return const Center(
            child: Text('Loaded'),
          );
        },
      ),
    );
  }
}
