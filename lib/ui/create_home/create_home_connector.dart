import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/create_home/create_home_action.dart';
import 'package:nestify/redux/create_home/create_home_state.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/common/avatar_picker/avatar_picker_view_model.dart';
import 'package:nestify/ui/common/popup_mixin.dart';
import 'package:nestify/ui/common/text_field/nestify_text_field_view_model.dart';
import 'package:nestify/ui/create_home/create_home_screen.dart';
import 'package:nestify/ui/create_home/create_home_view_model.dart';
import 'package:redux/redux.dart';

class CreateHomeConnector extends BaseConnector<CreateHomeViewModel>
    with PopupMixin {
  const CreateHomeConnector({super.key});

  @override
  CreateHomeViewModel convert(BuildContext context, Store<AppState> store) {
    final createHomeState = store.state.createHomeState;

    final CreateHomeStepViewModel createHomeStepViewModel;

    switch (createHomeState.createHomeStep) {
      case CreateHomeStep.homeProfile:
        createHomeStepViewModel = CreateHomeStepViewModel.homeProfile(
          homeAvatarViewModel: AvatarPickerViewModel(
              picture: createHomeState.homeProfileDraftState.homeAvatar,
              onClick: store.createCommand(
                createHomeState.homeProfileDraftState.homeAvatar == null
                    ? CreateHomePickHomeAvatarAction()
                    : RemoveCreateHomeAvatarAction(),
              )),
          homeNameViewModel: NestifyTextFieldViewModel(
            text: createHomeState.homeProfileDraftState.homeName,
            onTextChanged: store.createCommandWith(
              (newName) => CreateHomeNameChangedAction(newName),
            ),
          ),
          homeAddressViewModel: NestifyTextFieldViewModel(
            text: createHomeState.homeProfileDraftState.homeAddress,
            onTextChanged: store.createCommandWith(
              (newAddress) => CreateHomeAddressChangedAction(newAddress),
            ),
          ),
          homeAboutViewModel: NestifyTextFieldViewModel(
            text: createHomeState.homeProfileDraftState.homeAbout,
            onTextChanged: store.createCommandWith(
              (newAbout) => CreateHomeAboutChangedAction(newAbout),
            ),
          ),
          onNext: createHomeState.homeProfileDraftState.homeName.isNotEmpty
              ? store.createCommand(
                  CreateHomeStepChangedAction(CreateHomeStep.userProfile),
                )
              : null,
        );
        break;
      case CreateHomeStep.userProfile:
        createHomeStepViewModel = CreateHomeStepViewModel.userProfile(
          userAvatarViewModel: AvatarPickerViewModel(
              picture: createHomeState.userProfileDraftState.userAvatar,
              onClick: store.createCommand(
                createHomeState.userProfileDraftState.userAvatar == null
                    ? CreateHomePickUserAvatarAction()
                    : CreateHomeRemoveUserAvatarAction(),
              )),
          userNameViewModel: NestifyTextFieldViewModel(
            text: createHomeState.userProfileDraftState.userName,
            onTextChanged: store.createCommandWith(
              (newName) => CreateHomeUserNameChangedAction(newName),
            ),
          ),
          userBioViewModel: NestifyTextFieldViewModel(
            text: createHomeState.userProfileDraftState.userBio,
            onTextChanged: store.createCommandWith(
              (newBio) => CreateHomeUserBioChangedAction(newBio),
            ),
          ),
          isLoading: createHomeState.isLoading,
          onBack: store.createCommand(
            CreateHomeStepChangedAction(CreateHomeStep.homeProfile),
          ),
          onCreate: null,
        );
        break;
    }

    return CreateHomeViewModel(
      createHomeStepViewModel: createHomeStepViewModel,
      event: createHomeState.error?.whenOrNull(
        failedToObtainPhoto: () => CreateHomeEvent.failedToObtainPhoto(
          onProcessed: store.createCommand(
            CreateHomeErrorProcessedAction(),
          ),
        ),
        failedToCreate: () => CreateHomeEvent.failedToCreateHome(
          onProcessed: store.createCommand(
            CreateHomeErrorProcessedAction(),
          ),
        ),
      ),
    );
  }

  @override
  void onInit(Store<AppState> store) {
    store.dispatch(LoadAvailableColorsAction());
  }

  @override
  void onDispose(Store<AppState> store) {
    store.dispatch(CloseCreateHomeAction());
  }

  @override
  void processEvent(BuildContext context, CreateHomeViewModel viewModel) {
    final localization = AppLocalizations.of(context)!;
    if (viewModel.event != null) {
      showSnackBar(
        context,
        localization.commonError,
        viewModel.event!.onProcessed,
      );
    }
  }

  @override
  Widget screen(CreateHomeViewModel viewModel) =>
      CreateHomeScreen(viewModel: viewModel);
}
