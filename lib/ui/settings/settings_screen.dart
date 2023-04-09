import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/gen/assets.gen.dart';
import 'package:nestify/ui/settings/settings_view_model.dart';
import 'package:nestify/ui/settings/view/outlined_icon_button.dart';

class SettingsScreen extends StatelessWidget {
  final SettingsViewModel viewModel;

  const SettingsScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.settingsTitle),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Assets.images.appPicture.image(),
                const SizedBox(height: 16),
                OutlinedIconButton(
                  icon: Icons.person_outline,
                  text: localization.settingsProfile,
                  onClick: viewModel.onOpenProfile,
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: viewModel.onContactSupport,
                  child: Text(localization.settingsContactSupport),
                ),
                const SizedBox(height: 8),
                OutlinedIconButton(
                  icon: Icons.open_in_new_outlined,
                  text: localization.settingsPrivacyPolicy,
                  onClick: viewModel.onOpenPrivacyPolicy,
                ),
                const SizedBox(height: 8),
                OutlinedIconButton(
                  icon: Icons.open_in_new_outlined,
                  text: localization.settingsTermsAndConditions,
                  onClick: viewModel.onOpenTermsAndConditions,
                ),
                const SizedBox(height: 8),
                OutlinedIconButton(
                  icon: Icons.logout_outlined,
                  text: localization.commonLogout,
                  onClick: viewModel.onLogout,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
