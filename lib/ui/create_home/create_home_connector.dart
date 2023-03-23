import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/ui/base_connector.dart';
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
      homeName: '',
      address: '',
      about: '',
      onCreateHome: null,
      isLoading: false,
      event: null,
    );
  }

  @override
  void processEvent(BuildContext context, CreateHomeViewModel viewModel) {
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
  Widget screen(CreateHomeViewModel viewModel) =>
      CreateHomeScreen(viewModel: viewModel);
}
