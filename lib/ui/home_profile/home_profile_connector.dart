import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/home/home_action.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/home_profile/home_profile_screen.dart';
import 'package:nestify/ui/home_profile/home_profile_view_model.dart';
import 'package:redux/redux.dart';

class HomeProfileConnector extends BaseConnector<HomeProfileViewModel> {
  const HomeProfileConnector({super.key});

  @override
  HomeProfileViewModel convert(BuildContext context, Store<AppState> store) {
    final localization = AppLocalizations.of(context)!;
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
      membersDescription: localization.homeProfileMembers(
        homeState.homeUsers.length,
        homeState.colors.length,
      ),
      onAddMember: homeState.home!.adminId == homeState.currentUserId &&
              homeState.homeUsers.length < homeState.colors.length
          ? store.createCommand(
              const NavigationAction.setPath(AppRoute.addMember()),
            )
          : null,
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
