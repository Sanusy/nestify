import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/add_member/add_member_view_model.dart';

class AddMemberScreen extends StatelessWidget {
  final AddMemberViewModel viewModel;

  const AddMemberScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.addMemberTitle),
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
          final qrCodeSize = MediaQuery.of(context).size.width - (80 * 2);

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 48),
                      Text(
                        localization.addMemberDisclaimer,
                        style: theme.textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 64),
                        child: Container(
                          width: qrCodeSize,
                          height: qrCodeSize,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        localization.addMemberDisclaimerSubtitle,
                        style: theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 64),
                      const Spacer(),
                      OutlinedButton(
                        onPressed: loadedViewModel.onShareUrl,
                        child: Text(localization.addMemberShareInvite),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
