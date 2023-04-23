import 'package:flutter/material.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/home/home_action.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/home_profile/home_profile_screen.dart';
import 'package:nestify/ui/home_profile/home_profile_view_model.dart';
import 'package:redux/redux.dart';

class HomeProfileConnector extends BaseConnector<HomeProfileViewModel> {
  const HomeProfileConnector({super.key});

  @override
  HomeProfileViewModel convert(BuildContext context, Store<AppState> store) {
    final homeState = store.state.homeState;

    if (homeState.isLoading) {
      return const HomeProfileViewModel.loading();
    }

    if (homeState.error != null) {
      return HomeProfileViewModel.failed(
        onRetry: store.createCommand(InitHomeAction()),
      );
    }

    return HomeProfileViewModel.loaded(
      pictureUrl: homeState.home!.avatarUrl,
      homeName: homeState.home!.homeName,
      homeAddress: homeState.home!.address,
      about: homeState.home!.about,
      users: homeState.homeUsers
          .map((user) => HomeUserViewModel(
                userPictureUrl: user.avatarUrl,
                userName: user.userName,
                isAdmin: homeState.home!.adminId == user.id,
                onOpenUser: Command.stub,
              ))
          .toList(),
    );
  }

  @override
  Widget screen(HomeProfileViewModel viewModel) =>
      HomeProfileScreen(viewModel: viewModel);
}
