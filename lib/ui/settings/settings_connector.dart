import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/common_middlewares/common_actions.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/redux/settings/settings_action.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/common/popup_mixin.dart';
import 'package:nestify/ui/settings/settings_screen.dart';
import 'package:nestify/ui/settings/settings_view_model.dart';
import 'package:redux/redux.dart';

final class SettingsConnector extends BaseConnector<SettingsViewModel>
    with PopupMixin {
  const SettingsConnector({super.key});

  @override
  SettingsViewModel convert(BuildContext context, Store<AppState> store) {
    final settingsState = store.state.settingsState;
    return SettingsViewModel(
      onOpenProfile: settingsState.loading == null
          ? store.createCommand(PushNavigationAction(MyProfileRoute()))
          : null,
      onContactSupport: settingsState.loading == null
          ? store.createCommand(ContactSupportAction())
          : null,
      onOpenPrivacyPolicy: settingsState.loading == null ? Command.stub : null,
      onOpenTermsAndConditions:
          settingsState.loading == null ? Command.stub : null,
      onLogout: settingsState.loading == null
          ? store.createCommand(LogoutAction())
          : null,
      loading: settingsState.loading,
      event: settingsState.error?.when(
        failedToContactSupport: () => SettingsEvent.failedToContactSupport(
          onProcessed: store.createCommand(SettingsErrorProcessedAction()),
        ),
      ),
    );
  }

  @override
  void processEvent(BuildContext context, SettingsViewModel viewModel) {
    final localization = AppLocalizations.of(context)!;
    viewModel.event?.when(
      failedToContactSupport: (onProcessed) => showSnackBar(
        context,
        localization.commonError,
        onProcessed,
      ),
    );
  }

  @override
  Widget screen(SettingsViewModel viewModel) =>
      SettingsScreen(viewModel: viewModel);
}
