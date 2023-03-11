import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/login/login_action.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/login/login_screen.dart';
import 'package:nestify/ui/login/login_view_model.dart';
import 'package:nestify/ui/login/view/login_button_view_model.dart';
import 'package:redux/redux.dart';

class LoginConnector extends BaseConnector<LoginViewModel> {
  const LoginConnector({super.key});

  @override
  LoginViewModel convert(BuildContext context, Store<AppState> store) {
    final localization = AppLocalizations.of(context)!;
    final loginState = store.state.loginState;

    return LoginViewModel(
      googleLoginViewModel: loginState.isGoogleLoginInProgress
          ? const LoginButtonViewModel.loading()
          : LoginButtonViewModel.available(
              title: localization.loginLoginWithGoogle,
              onLogin: Command(() {
                store.dispatch(LoginWithGoogleAction());
              }),
            ),
      isFailed: loginState.isFailed,
    );
  }

  @override
  Widget screen(LoginViewModel viewModel) => LoginScreen(viewModel: viewModel);
}
