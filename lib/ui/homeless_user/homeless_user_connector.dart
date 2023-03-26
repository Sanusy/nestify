import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/homeless_user/homeless_user_action.dart';
import 'package:nestify/redux/login/login_action.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/common/popup_mixin.dart';
import 'package:nestify/ui/homeless_user/homeless_user_screen.dart';
import 'package:nestify/ui/homeless_user/homeless_user_view_model.dart';
import 'package:redux/redux.dart';

class HomelessUserConnector extends BaseConnector<HomelessUserViewModel>
    with PopupMixin {
  const HomelessUserConnector({super.key});

  @override
  HomelessUserViewModel convert(BuildContext context, Store<AppState> store) {
    final homelessUserState = store.state.homelessUserState;
    return HomelessUserViewModel(
      onCreateHome: homelessUserState.isLoading
          ? null
          : store.createCommand(CreateHomeDraftAction()),
      onScanQrCode: homelessUserState.isLoading ? null : Command.stub,
      onLogout: homelessUserState.isLoading
          ? null
          : store.createCommand(LogoutAction()),
      isLoading: homelessUserState.isLoading,
      event: homelessUserState.error?.when(
        failedToCreateHomeDraft: () =>
            HomelessUserEvent.failedToCreateHomeDraft(
          onProcessed: store.createCommand(
            HomelessUserErrorProcessedAction(),
          ),
        ),
      ),
    );
  }

  @override
  void processEvent(BuildContext context, HomelessUserViewModel viewModel) {
    final localization = AppLocalizations.of(context)!;
    viewModel.event?.when(
      failedToCreateHomeDraft: (onProcessed) => showSnackBar(
        context,
        localization.commonError,
        onProcessed,
      ),
    );
  }

  @override
  Widget screen(HomelessUserViewModel viewModel) =>
      HomelessUserScreen(viewModel: viewModel);
}
