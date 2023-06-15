import 'package:flutter/material.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/home_profile/home_profile_action.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/home_profile/components/leave_home_dialog/leave_home_dialog.dart';
import 'package:nestify/ui/home_profile/components/leave_home_dialog/leave_home_dialog_view_model.dart';
import 'package:redux/redux.dart';

final class LeaveHomeDialogConnector
    extends BaseConnector<LeaveHomeDialogViewModel> {
  const LeaveHomeDialogConnector({super.key});

  @override
  void onDispose(Store<AppState> store) {
    store.dispatch(ClosedLeaveHomeDialogAction());
    super.onDispose(store);
  }

  @override
  LeaveHomeDialogViewModel convert(
      BuildContext context, Store<AppState> store) {
    final homeState = store.state.homeState;
    final isUserAdmin = homeState.home?.adminId == homeState.currentUserId;

    final onLeaveHomeCommand = Command(() {
      store.dispatch(LeaveHomeAction());
      store.dispatch(const PopNavigationAction());
    });

    /// Pops leave home dialog
    final onCancelCommand = store.createCommand(const PopNavigationAction());

    if (isUserAdmin && homeState.homeUsers.length > 2) {
      final selectedAdmin =
          store.state.homeProfileState.leaveHomeState?.newAdmin;
      return LeaveHomeDialogViewModel.adminWithUsers(
        users: homeState.homeUsers
            .where((homeUser) => homeUser.id != homeState.currentUserId)
            .map(
              (homeUser) => SelectAdminViewModel(
                userPictureUrl: homeUser.avatarUrl,
                userName: homeUser.userName,
                onSelectAdmin: selectedAdmin?.id == homeUser.id
                    ? null
                    : store.createCommand(SelectNewAdminAction(homeUser)),
              ),
            )
            .toList(),
        onLeaveHome: selectedAdmin != null ? onLeaveHomeCommand : null,
        onCancel: onCancelCommand,
      );
    } else if (isUserAdmin && homeState.homeUsers.length > 1) {
      final newAdmin = homeState.homeUsers
          .firstWhere((homeUser) => homeUser.id != homeState.currentUserId);
      return LeaveHomeDialogViewModel.admin(
        newAdminName: newAdmin.userName,
        onLeaveHome: Command(() {
          store.dispatch(SelectNewAdminAction(newAdmin));
          store.dispatch(LeaveHomeAction());
          store.dispatch(const PopNavigationAction());
        }),
        onCancel: onCancelCommand,
      );
    }

    return LeaveHomeDialogViewModel.user(
      onLeaveHome: onLeaveHomeCommand,
      onCancel: onCancelCommand,
    );
  }

  @override
  Widget screen(LeaveHomeDialogViewModel viewModel) =>
      LeaveHomeDialog(viewModel: viewModel);
}
