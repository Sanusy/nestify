import 'package:flutter/material.dart';
import 'package:nestify/redux/add_member/add_member_action.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/ui/add_member/add_member_screen.dart';
import 'package:nestify/ui/add_member/add_member_view_model.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:redux/redux.dart';

class AddMemberConnector extends BaseConnector<AddMemberViewModel> {
  const AddMemberConnector({super.key});

  @override
  void onInit(Store<AppState> store) {
    store.dispatch(ObtainInviteUrlAction());
  }

  @override
  AddMemberViewModel convert(BuildContext context, Store<AppState> store) {
    final addMemberState = store.state.addMemberState;
    if (addMemberState.isLoading) {
      return const AddMemberViewModel.loading();
    }

    if (addMemberState.error != null) {
      return AddMemberViewModel.failed(
          onRetry: store.createCommand(ObtainInviteUrlAction()));
    }

    return AddMemberViewModel.loaded(
      inviteUrl: addMemberState.inviteUrl!,
      onShareUrl: Command.stub,
    );
  }

  @override
  Widget screen(AddMemberViewModel viewModel) =>
      AddMemberScreen(viewModel: viewModel);
}
