import 'package:flutter/material.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/middleware/common_actions.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
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
    return HomelessUserViewModel(
      onCreateHome: store.createCommand(
        const NavigationAction.push(
          AppRoute.createHome(),
        ),
      ),
      onScanQrCode: Command.stub,
      onLogout: store.createCommand(LogoutAction()),
    );
  }

  @override
  Widget screen(HomelessUserViewModel viewModel) =>
      HomelessUserScreen(viewModel: viewModel);
}
