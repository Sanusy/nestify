import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/home/home_action.dart';
import 'package:nestify/redux/home_profile/home_profile_action.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/common/app_bar_actions_view/app_bar_action_view_model.dart';
import 'package:nestify/ui/common/user_tile_view/user_tile_view_model.dart';
import 'package:nestify/ui/home_profile/components/leave_home_dialog/leave_home_dialog_connector.dart';
import 'package:nestify/ui/home_profile/home_profile_screen.dart';
import 'package:nestify/ui/home_profile/home_profile_view_model.dart';
import 'package:redux/redux.dart';

final class HomeProfileConnector extends BaseConnector<HomeProfileViewModel> {
  const HomeProfileConnector({super.key});

  @override
  HomeProfileViewModel convert(BuildContext context, Store<AppState> store) {
    final localization = AppLocalizations.of(context)!;
    final homeState = store.state.homeState;

    if (homeState.isLoading ||
        store.state.homeProfileState.isLoading ||
        homeState.home == null) {
      return const HomeProfileViewModel.loading();
    }

    if (homeState.error != null) {
      return HomeProfileViewModel.failed(
        onRetry: store.createCommand(InitHomeAction()),
      );
    }

    final isUserAdmin = homeState.home?.adminId == homeState.currentUserId;

    final home = homeState.home!;

    return HomeProfileViewModel.loaded(
      appBarActions: [
        if (home.usersIds.length > 1)
          AppBarActionViewModel(
            onClick: Command(() {
              showDialog(
                context: context,
                builder: (_) => const LeaveHomeDialogConnector(),
              );
            }),
            title: localization.homeProfileLeaveHome,
            icon: Icons.logout_outlined,
            isDestructive: false,
          ),
        if (isUserAdmin)
          AppBarActionViewModel(
            onClick: store.createCommand(DeleteHomeAction()),
            title: localization.homeProfileDeleteHome,
            icon: Icons.delete_forever_outlined,
            isDestructive: true,
          ),
      ],
      pictureUrl: home.avatarUrl,
      homeName: home.homeName,
      homeAddress: home.address,
      about: home.about,
      membersDescription: localization.homeProfileMembers(
        homeState.homeUsers.length,
        homeState.colors.length,
      ),
      onAddMember:
          isUserAdmin && homeState.homeUsers.length < homeState.colors.length
              ? store.createCommand(
                  SetPathNavigationAction(AddMemberRoute()),
                )
              : null,
      users: homeState.homeUsers
          .map((user) => UserTileViewModel(
                userPictureUrl: user.avatarUrl,
                userName: user.userName,
                isAdmin: home.adminId == user.id,
                onOpenUser: Command.stub,
              ))
          .toList(),
    );
  }

  @override
  Widget screen(HomeProfileViewModel viewModel) =>
      HomeProfileScreen(viewModel: viewModel);
}
