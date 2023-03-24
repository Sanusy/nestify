import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/gen/assets.gen.dart';
import 'package:nestify/ui/homeless_user/homeless_user_view_model.dart';

class HomelessUserScreen extends StatelessWidget {
  final HomelessUserViewModel viewModel;

  const HomelessUserScreen({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              Assets.images.appPicture.image(),
              const SizedBox(height: 32),
              Text(
                localization.homelessUserDescription,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: viewModel.onCreateHome?.command,
                child: viewModel.isLoading
                    ? const Center(
                        child: SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : Text(localization.homelessUserCreateHome),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: viewModel.onScanQrCode?.command,
                child: Text(localization.homelessUserScanQrCode),
              ),
              const Spacer(),
              TextButton(
                onPressed: viewModel.onLogout?.command,
                child: Text(localization.commonLogout),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
