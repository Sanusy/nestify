import 'package:flutter/material.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/home_profile/home_profile_screen.dart';
import 'package:nestify/ui/home_profile/home_profile_view_model.dart';
import 'package:redux/redux.dart';

class HomeProfileConnector extends BaseConnector<HomeProfileViewModel> {
  const HomeProfileConnector({super.key});

  @override
  HomeProfileViewModel convert(BuildContext context, Store<AppState> store) {
    return const HomeProfileViewModel.loading();
  }

  @override
  Widget screen(HomeProfileViewModel viewModel) =>
      HomeProfileScreen(viewModel: viewModel);
}
