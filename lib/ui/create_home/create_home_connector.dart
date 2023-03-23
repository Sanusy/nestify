import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/create_home/create_home_action.dart';
import 'package:nestify/redux/login/login_action.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/common/popup_mixin.dart';
import 'package:nestify/ui/create_home/create_home_screen.dart';
import 'package:nestify/ui/create_home/create_home_view_model.dart';
import 'package:redux/redux.dart';

class CreateHomeConnector extends BaseConnector<CreateHomeViewModel>
    with PopupMixin {
  const CreateHomeConnector({super.key});

  @override
  CreateHomeViewModel convert(BuildContext context, Store<AppState> store) {
    final createHomeState = store.state.createHomeState;
    return CreateHomeViewModel(
      onDiscard: store.createCommand(DiscardCreateHomeAction()),
      onLogout: store.createCommand(LogoutAction()),
      homeName: createHomeState.homeName,
      address: createHomeState.homeAddress,
      about: createHomeState.about,
      onCreateHome: createHomeState.homeName.isEmpty ? null : Command.stub,
      isLoading: createHomeState.isLoading,
      event: createHomeState.error?.when(
        failedToObtainPhoto: () =>
            CreateHomeEvent.failedToObtainPhoto(onProcessed: Command.stub),
        failedToCreate: () =>
            CreateHomeEvent.failedToCreateHome(onProcessed: Command.stub),
      ),
    );
  }

  @override
  void processEvent(BuildContext context, CreateHomeViewModel viewModel) {
    final localization = AppLocalizations.of(context)!;
    if (viewModel.event != null) {
      showSnackBar(
        context,
        localization.commonError,
        viewModel.event!.onProcessed,
      );
    }
  }

  @override
  Widget screen(CreateHomeViewModel viewModel) =>
      CreateHomeScreen(viewModel: viewModel);
}
