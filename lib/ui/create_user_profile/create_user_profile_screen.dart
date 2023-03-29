import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/common/avatar_picker/avatar_picker.dart';
import 'package:nestify/ui/common/text_field/nestify_text_field.dart';
import 'package:nestify/ui/create_user_profile/create_user_profile_app_bar_actions.dart';
import 'package:nestify/ui/create_user_profile/create_user_profile_view_model.dart';

class CreateUserProfileScreen extends StatelessWidget {
  final CreateUserProfileViewModel viewModel;

  const CreateUserProfileScreen({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.createUserProfileTitle),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: CreateUserProfileAppBarActions.discard,
                  child: Text(localization.commonDiscard),
                ),
                PopupMenuItem(
                  value: CreateUserProfileAppBarActions.logOut,
                  child: Text(localization.commonLogout),
                ),
              ];
            },
            onSelected: (action) {
              switch (action) {
                case CreateUserProfileAppBarActions.discard:
                  viewModel.onDiscard();
                  break;
                case CreateUserProfileAppBarActions.logOut:
                  viewModel.onLogout();
                  break;
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: AvatarPicker(
                  viewModel: viewModel.userAvatarViewModel,
                  backgroundIcon: Icons.person_outline_outlined,
                ),
              ),
              const SizedBox(height: 32),
              NestifyTextField(
                viewModel: viewModel.nameViewModel,
                label: localization.createUserProfileNameHint,
              ),
              const SizedBox(height: 32),
              NestifyMultilineTextField(
                viewModel: viewModel.bioViewModel,
                label: localization.createUserProfileBioHint,
                height: 120,
              ),
              const SizedBox(height: 32),
              Text(
                localization.createUserProfileSelectColorTitle,
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                localization.createUserProfileSelectColorDescription,
                style: theme.textTheme.bodySmall,
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: viewModel.onSaveProfile?.command,
                child: viewModel.isLoading
                    ? const Center(
                        child: SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : Text(localization.createHomeSaveProfile),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
