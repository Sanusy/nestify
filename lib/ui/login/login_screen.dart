import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/gen/assets.gen.dart';
import 'package:nestify/ui/login/login_view_model.dart';
import 'package:nestify/ui/login/view/login_button.dart';

class LoginScreen extends StatelessWidget {
  final LoginViewModel viewModel;

  const LoginScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 32),
              Assets.images.appPicture.image(),
              const SizedBox(height: 32),
              Text(
                localization.loginWelcomeToNestify,
                style: theme.textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              Text(
                localization.loginToStartLoginWith,
                style: theme.textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              LoginButton(viewModel: viewModel.googleLoginViewModel),
              const SizedBox(height: 8),
              if (viewModel.isFailed)
                Text(
                  localization.loginFailedToLogin,
                  style: TextStyle(color: theme.colorScheme.error),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
