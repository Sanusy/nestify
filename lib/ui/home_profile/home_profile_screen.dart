import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/home_profile/components/home_profile_loaded_body_view.dart';
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
        failed: (failedViewModel) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(localization.commonError),
              TextButton(
                onPressed: failedViewModel.onRetry,
                child: Text(localization.commonRetry),
              ),
            ],
          ),
        ),
        loaded: (loadedViewModel) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: HomeProfileLoadedBodyView(viewModel: loadedViewModel),
          );
        },
      ),
    );
  }
}
