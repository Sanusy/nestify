import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/create_home/create_home_action.dart';
import 'package:nestify/redux/create_home/create_home_state.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/common/avatar_picker/avatar_picker_view_model.dart';
import 'package:nestify/ui/common/color_selector/color_selector_item_view_model.dart';
import 'package:nestify/ui/common/popup_mixin.dart';
import 'package:nestify/ui/common/text_field/nestify_text_field_view_model.dart';
import 'package:nestify/ui/create_home/create_home_screen.dart';
import 'package:nestify/ui/create_home/create_home_view_model.dart';
import 'package:nestify/ui/create_home/user_profile_step/create_home_color_selector/create_home_color_selector_view_model.dart';
import 'package:redux/redux.dart';

final class CreateHomeConnector extends BaseConnector<CreateHomeViewModel>
    with PopupMixin {
  const CreateHomeConnector({super.key});

  @override
  CreateHomeViewModel convert(BuildContext context, Store<AppState> store) {
    final createHomeState = store.state.createHomeState;

    final CreateHomeStepViewModel createHomeStepViewModel =
    switch (createHomeState.createHomeStep) {
      CreateHomeStep.homeProfile =>
          CreateHomeStepViewModel.homeProfile(
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
          ),
      CreateHomeStep.userProfile =>
          CreateHomeStepViewModel.userProfile(
            userAvatarViewModel: AvatarPickerViewModel(
                picture: createHomeState.userProfileDraftState.userAvatar,
                onClick: createHomeState.isLoading
                    ? null
                    : store.createCommand(
                  createHomeState.userProfileDraftState.userAvatar == null
                      ? CreateHomePickUserAvatarAction()
                      : CreateHomeRemoveUserAvatarAction(),
                )),
            userNameViewModel: NestifyTextFieldViewModel(
              text: createHomeState.userProfileDraftState.userName,
              onTextChanged: createHomeState.isLoading
                  ? null
                  : store.createCommandWith(
                    (newName) => CreateHomeUserNameChangedAction(newName),
              ),
            ),
            userBioViewModel: NestifyTextFieldViewModel(
              text: createHomeState.userProfileDraftState.userBio,
              onTextChanged: createHomeState.isLoading
                  ? null
                  : store.createCommandWith(
                    (newBio) => CreateHomeUserBioChangedAction(newBio),
              ),
            ),
            isLoading: createHomeState.isLoading,
            onBack: createHomeState.isLoading
                ? null
                : store.createCommand(
              CreateHomeStepChangedAction(CreateHomeStep.homeProfile),
            ),
            onCreate: createHomeState.canCreateHome
                ? store.createCommand(CreateHomeAction())
                : null,
            colorSelectorViewModel: createHomeState.colorsState.map(
              loading: (_) => const CreateHomeColorSelectorViewModel.loading(),
              error: (_) =>
                  CreateHomeColorSelectorViewModel.error(
                      onRetry: store.createCommand(
                          LoadAvailableColorsAction())),
              loaded: (availableColors) {
                return CreateHomeColorSelectorViewModel.loaded(
                  availableColors: availableColors.availableColors
                      .map(
                        (availableColor) =>
                        ColorSelectorItemViewModel(
                          onSelect: createHomeState
                              .userProfileDraftState.selectedColor ==
                              availableColor
                              ? null
                              : store.createCommand(
                            CreateHomeColorSelectedAction(
                              availableColor,
                            ),
                          ),
                          color: availableColor.toColor,
                          isEnabled: true,
                        ),
                  )
                      .toList()
                    ..sort((firstColor, _) => firstColor.isEnabled ? -1 : 1),
                );
              },
            ),
          ),
    };

    return CreateHomeViewModel(
      quitConfirmation: createHomeState.hasChanges
          ? store.baseQuitConfirmationViewModel
          : null,
      createHomeStepViewModel: createHomeStepViewModel,
      event: createHomeState.error?.whenOrNull(
        failedToObtainPhoto: () =>
            CreateHomeEvent.failedToObtainPhoto(
              onProcessed: store.createCommand(
                CreateHomeErrorProcessedAction(),
              ),
            ),
        failedToCreate: () =>
            CreateHomeEvent.failedToCreateHome(
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
