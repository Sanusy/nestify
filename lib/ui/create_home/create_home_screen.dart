import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    final theme = Theme.of(context);

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
          )
        ],
      ),
      body: Center(
        child: Text('Create home'),
      ),
    );
  }
}
