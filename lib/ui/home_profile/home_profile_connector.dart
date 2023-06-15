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
import 'package:nestify/ui/home_profile/components/leave_home_dialog/leave_home_dialog.dart';
import 'package:nestify/ui/home_profile/components/leave_home_dialog/leave_home_dialog_view_model.dart';
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
              _showLeaveHomeDialog(
                context: context,
                leaveHomeViewModel: _buildLeaveHomeDialogViewModel(store),
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

  void _showLeaveHomeDialog({
    required BuildContext context,
    required LeaveHomeDialogViewModel leaveHomeViewModel,
  }) {
    showDialog(
      context: context,
      builder: (_) {
        return LeaveHomeDialog(viewModel: leaveHomeViewModel);
      },
    );
  }

  LeaveHomeDialogViewModel _buildLeaveHomeDialogViewModel(
    Store<AppState> store,
  ) {
    final homeState = store.state.homeState;
    final isUserAdmin = homeState.home?.adminId == homeState.currentUserId;

    final onCancelCommand = Command(() {
      // TODO: Clear selected user state from here

      /// Pops leave home dialog
      store.dispatch(const PopNavigationAction());
    });

    if (isUserAdmin && homeState.homeUsers.length > 2) {
      return LeaveHomeDialogViewModel.adminWithUsers(
        users: homeState.homeUsers
            .where((homeUser) => homeUser.id != homeState.currentUserId)
            .map((homeUser) => SelectAdminViewModel(
                  userPictureUrl: homeUser.avatarUrl,
                  userName: homeUser.userName,
                  onSelectAdmin: null,
                ))
            .toList(),
        onLeaveHome: null,
        onCancel: onCancelCommand,
      );
    } else if (isUserAdmin && homeState.homeUsers.length > 1) {
      return LeaveHomeDialogViewModel.admin(
        newAdminName: homeState.homeUsers
            .firstWhere((homeUser) => homeUser.id != homeState.currentUserId)
            .userName,
        onLeaveHome: Command.stub,
        onCancel: onCancelCommand,
      );
    }

    return LeaveHomeDialogViewModel.user(
      onLeaveHome: Command.stub,
      onCancel: onCancelCommand,
    );
  }

  @override
  Widget screen(HomeProfileViewModel viewModel) =>
      HomeProfileScreen(viewModel: viewModel);
}
