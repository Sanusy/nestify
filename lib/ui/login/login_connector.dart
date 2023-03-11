import 'package:flutter/material.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/login/login_screen.dart';
import 'package:nestify/ui/login/login_view_model.dart';
import 'package:redux/redux.dart';

class LoginConnector extends BaseConnector<LoginViewModel> {
  const LoginConnector({super.key});

  @override
  LoginViewModel convert(Store<AppState> store) {
    return const LoginViewModel(onLogInWithGoogle: null);
  }

  @override
  Widget screen(LoginViewModel viewModel) => LoginScreen(viewModel: viewModel);
}
