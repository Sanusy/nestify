import 'package:flutter/material.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/common_middlewares/common_actions.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/common/popup_mixin.dart';
import 'package:nestify/ui/homeless_user/homeless_user_screen.dart';
import 'package:nestify/ui/homeless_user/homeless_user_view_model.dart';
import 'package:redux/redux.dart';

final class HomelessUserConnector extends BaseConnector<HomelessUserViewModel>
    with PopupMixin {
  const HomelessUserConnector({super.key});

  @override
  HomelessUserViewModel convert(BuildContext context, Store<AppState> store) {
    return HomelessUserViewModel(
      onCreateHome: store.createCommand(
        PushNavigationAction(
          CreateHomeRoute(),
        ),
      ),
      onScanQrCode: store.createCommand(
        SetPathNavigationAction(
          ScanQrCodeRoute(),
        ),
      ),
      onLogout: store.createCommand(LogoutAction()),
    );
  }

  @override
  Widget screen(HomelessUserViewModel viewModel) =>
      HomelessUserScreen(viewModel: viewModel);
}
