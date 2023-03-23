import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/common/avatar_picker/avatar_picker.dart';
import 'package:nestify/ui/common/text_field/nestify_text_field.dart';
import 'package:nestify/ui/create_home/create_home_app_bar_actions.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.createHomeTitle),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: CreateHomeAppBarActions.discard,
                  child: Text(localization.commonDiscard),
                ),
                PopupMenuItem(
                  value: CreateHomeAppBarActions.logOut,
                  child: Text(localization.commonLogout),
                ),
              ];
            },
            onSelected: (action) {
              switch (action) {
                case CreateHomeAppBarActions.discard:
                  viewModel.onDiscard();
                  break;
                case CreateHomeAppBarActions.logOut:
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AvatarPicker(
                viewModel: viewModel.homeAvatarViewModel,
                backgroundIcon: Icons.home_outlined,
              ),
              const SizedBox(height: 32),
              NestifyTextField(
                viewModel: viewModel.homeNameViewModel,
                label: localization.createHomeName,
              ),
              const SizedBox(height: 32),
              NestifyTextField(
                viewModel: viewModel.homeNameViewModel,
                label: localization.createHomeAddress,
              ),
              const SizedBox(height: 32),
              NestifyMultilineTextField(
                viewModel: viewModel.homeNameViewModel,
                label: localization.createHomeAbout,
                height: 120,
              ),
              const Spacer(),
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
                    : Text(localization.createHomeSaveProfile),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
