import 'package:flutter/material.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/create_home/create_home_action.dart';
import 'package:nestify/redux/create_user_profile/create_user_profile_action.dart';
import 'package:nestify/redux/login/login_action.dart';
import 'package:nestify/ui/base_connector.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/common/avatar_picker/avatar_picker_view_model.dart';
import 'package:nestify/ui/common/text_field/nestify_text_field_view_model.dart';
import 'package:nestify/ui/create_user_profile/create_user_profile_screen.dart';
import 'package:nestify/ui/create_user_profile/create_user_profile_view_model.dart';
import 'package:redux/redux.dart';

class CreateUserProfileConnector
    extends BaseConnector<CreateUserProfileViewModel> {
  const CreateUserProfileConnector({super.key});

  @override
  CreateUserProfileViewModel convert(
    BuildContext context,
    Store<AppState> store,
  ) {
    final createUserProfileState = store.state.createUserProfileState;
    return CreateUserProfileViewModel(
      onLogout: store.createCommand(LogoutAction()),
      //TODO: In future use different action based on creating home or joining home
      onDiscard: store.createCommand(DiscardCreateHomeAction()),
      userAvatarViewModel: AvatarPickerViewModel(
        picture: createUserProfileState.avatar,
        onClick: store.createCommand(
          createUserProfileState.avatar == null
              ? PickCreateUserProfileAvatarAction()
              : RemoveCreateUserProfileAvatarAction(),
        ),
      ),
      nameViewModel: NestifyTextFieldViewModel(
        text: createUserProfileState.name,
        onTextChanged: store.createCommandWith(
          (newName) => UserNameChangedAction(newName),
        ),
      ),
      bioViewModel: NestifyTextFieldViewModel(
        text: createUserProfileState.bio,
        onTextChanged: store.createCommandWith(
          (newBio) => UserNameChangedAction(newBio),
        ),
      ),
      isLoading: createUserProfileState.isLoading,
      onSaveProfile: null,
    );
  }

  @override
  Widget screen(CreateUserProfileViewModel viewModel) =>
      CreateUserProfileScreen(viewModel: viewModel);
}
