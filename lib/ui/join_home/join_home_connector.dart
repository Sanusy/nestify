import 'package:flutter/material.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/join_home/join_home_action.dart';
import 'package:nestify/redux/join_home/join_home_state.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/common/avatar_picker/avatar_picker_view_model.dart';
import 'package:nestify/ui/common/color_selector/color_selector_item_view_model.dart';
import 'package:nestify/ui/common/text_field/nestify_text_field_view_model.dart';
import 'package:nestify/ui/common/user_tile_view/user_tile_view_model.dart';
import 'package:nestify/ui/join_home/join_home_screen.dart';
import 'package:nestify/ui/join_home/join_home_view_model.dart';
import 'package:redux/redux.dart';

final class JoinHomeConnector extends BaseConnector<JoinHomeViewModel> {
  const JoinHomeConnector({super.key});

  @override
  JoinHomeViewModel convert(BuildContext context, Store<AppState> store) {
    final joinHomeState = store.state.joinHomeState;

    if (joinHomeState.isLoading) {
      return const JoinHomeViewModel.loading();
    }

    if (joinHomeState.error != null) {
      return JoinHomeViewModel.error(
        onRetry: store.createCommand(
          InitJoinHomeAction(homeToJoin: joinHomeState.homeToJoin!),
        ),
      );
    }

    final homeToJoin = joinHomeState.homeToJoin!;

    return switch (joinHomeState.joinHomeStep) {
      JoinHomeStep.homeInfo => JoinHomeViewModel.homeDetails(
          pictureUrl: homeToJoin.avatarUrl,
          homeName: homeToJoin.homeName,
          homeAddress: homeToJoin.address,
          about: homeToJoin.about,
          users: joinHomeState.homeUsers
              .map((user) => UserTileViewModel(
                    userPictureUrl: user.avatarUrl,
                    userName: user.userName,
                    isAdmin: homeToJoin.adminId == user.id,
                    onOpenUser: Command.stub,
                  ))
              .toList(),
          onNext: store.createCommand(
            JoinHomeChangeStepAction(JoinHomeStep.userProfile),
          ),
        ),
      JoinHomeStep.userProfile => JoinHomeViewModel.userProfile(
          quitConfirmation: joinHomeState.hasChanges
              ? store.baseQuitConfirmationViewModel
              : null,
          userAvatarViewModel: AvatarPickerViewModel.file(
              picture: joinHomeState.userProfileDraftState.userAvatar,
              onClick: joinHomeState.isLoading
                  ? null
                  : store.createCommand(
                      joinHomeState.userProfileDraftState.userAvatar == null
                          ? JoinHomePickUserAvatarAction()
                          : JoinHomeRemoveUserAvatarAction(),
                    )),
          userNameViewModel: NestifyTextFieldViewModel(
            text: joinHomeState.userProfileDraftState.userName,
            onTextChanged: joinHomeState.isJoinInProgress
                ? null
                : store.createCommandWith(
                    (newName) => JoinHomeUserNameChangedAction(newName),
                  ),
          ),
          userBioViewModel: NestifyTextFieldViewModel(
            text: joinHomeState.userProfileDraftState.userBio,
            onTextChanged: joinHomeState.isJoinInProgress
                ? null
                : store.createCommandWith(
                    (newBio) => JoinHomeUserBioChangedAction(newBio),
                  ),
          ),
          isLoading: joinHomeState.isJoinInProgress,
          availableColors: joinHomeState.colors
              .map((color) => ColorSelectorItemViewModel(
                  onSelect: joinHomeState.userProfileDraftState.selectedColor ==
                              color ||
                          joinHomeState.homeUsers
                              .any((user) => user.colorId == color.id)
                      ? null
                      : store.createCommand(JoinHomeColorSelectedAction(color)),
                  isEnabled: !joinHomeState.homeUsers
                      .any((user) => user.colorId == color.id),
                  color: color.toColor))
              .toList()
            ..sort(ColorSelectorItemViewModel.colorSorting),
          onJoin: joinHomeState.canJoinHome
              ? store.createCommand(JoinHomeAction())
              : null,
        ),
    };
  }

  @override
  void onDispose(Store<AppState> store) {
    store.dispatch(ResetJoinHomeStateAction());
  }

  @override
  Widget screen(JoinHomeViewModel viewModel) =>
      JoinHomeScreen(viewModel: viewModel);
}
