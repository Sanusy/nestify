import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
      body: Center(
        child: Text(localization.createUserProfileTitle),
      ),
    );
  }
}
