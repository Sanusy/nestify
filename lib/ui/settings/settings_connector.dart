import 'package:flutter/material.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/settings/settings_screen.dart';
import 'package:nestify/ui/settings/settings_view_model.dart';
import 'package:redux/redux.dart';

class SettingsConnector extends BaseConnector<SettingsViewModel> {
  const SettingsConnector({super.key});

  @override
  SettingsViewModel convert(BuildContext context, Store<AppState> store) {
    return SettingsViewModel(
      onOpenProfile: Command.stub,
      onContactSupport: Command.stub,
      onOpenPrivacyPolicy: Command.stub,
      onOpenTermsAndConditions: Command.stub,
      onLogout: Command.stub,
    );
  }

  @override
  Widget screen(SettingsViewModel viewModel) =>
      SettingsScreen(viewModel: viewModel);
}
