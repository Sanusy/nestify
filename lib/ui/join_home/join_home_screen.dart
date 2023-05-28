import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/join_home/components/home_details_view.dart';
import 'package:nestify/ui/join_home/join_home_view_model.dart';

class JoinHomeScreen extends StatelessWidget {
  final JoinHomeViewModel viewModel;

  const JoinHomeScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.joinHomeTitle),
      ),
      body: viewModel.map(
          loading: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
          error: (failedViewModel) => Center(
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
          homeDetails: (detailsViewModel) {
            return HomeToJoinDetailsView(viewModel: detailsViewModel);
          },
          userProfile: (userProfileViewModel) {
            return Placeholder();
          }),
    );
  }
}
