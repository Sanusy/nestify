import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/redux/add_member/add_member_action.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/ui/add_member/add_member_screen.dart';
import 'package:nestify/ui/add_member/add_member_view_model.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:redux/redux.dart';

final class AddMemberConnector extends BaseConnector<AddMemberViewModel> {
  const AddMemberConnector({super.key});

  @override
  void onInit(Store<AppState> store) {
    store.dispatch(ObtainInviteUrlAction());
  }

  @override
  AddMemberViewModel convert(BuildContext context, Store<AppState> store) {
    final localization = AppLocalizations.of(context)!;
    final addMemberState = store.state.addMemberState;
    if (addMemberState.isLoading) {
      return const AddMemberViewModel.loading();
    }

    if (addMemberState.error != null ||
        store.state.homeState.home == null ||
        addMemberState.inviteUrl == null) {
      return AddMemberViewModel.failed(
        onRetry: store.createCommand(ObtainInviteUrlAction()),
      );
    }

    final home = store.state.homeState.home!;

    return AddMemberViewModel.loaded(
      homeInviteViewModel: HomeInviteViewModel(
        homeName: home.homeName,
        homeAddress: home.address,
        humeAvatarUrl: home.avatarUrl,
        inviteUrl: addMemberState.inviteUrl!,
      ),
      isInviteCapturingInProgress: addMemberState.isInviteCapturingInProgress,
      onCreatePictureInvite: store.createCommand(CreateInvitePictureAction()),
      onShareInvite: store.createCommandWith(
        (pictureBytes) => ShareInviteAction(
          pictureBytes: pictureBytes,
          inviteDescription: localization.addMemberShareDescription,
        ),
      ),
    );
  }

  @override
  Widget screen(AddMemberViewModel viewModel) =>
      AddMemberScreen(viewModel: viewModel);
}
