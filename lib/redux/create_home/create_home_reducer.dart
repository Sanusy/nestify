import 'package:nestify/redux/create_home/create_home_action.dart';
import 'package:nestify/redux/create_home/create_home_state.dart';
import 'package:redux/redux.dart';

final createHomeStateReducer = combineReducers<CreateHomeState>([
  TypedReducer(_createHomeStepChanged),
  TypedReducer(_homeNameChanged),
  TypedReducer(_homeAddressChanged),
  TypedReducer(_homeAboutChanged),
  TypedReducer(_pickedHomeAvatar),
  TypedReducer(_removeHomeAvatar),
  TypedReducer(_userNameChanged),
  TypedReducer(_userBioChanged),
  TypedReducer(_pickedUserAvatar),
  TypedReducer(_removeUserAvatar),
  TypedReducer(_failedToPickAvatar),
  TypedReducer(_createHome),
  TypedReducer(_createHomeClosed),
  TypedReducer(_failedToCreateHome),
  TypedReducer(_errorProcessed),
]);

CreateHomeState _createHomeStepChanged(
  CreateHomeState state,
  CreateHomeStepChangedAction action,
) {
  return state.copyWith(
    createHomeStep: action.step,
  );
}

CreateHomeState _homeNameChanged(
  CreateHomeState state,
  CreateHomeNameChangedAction action,
) {
  return state.copyWith(
    homeProfileDraftState: state.homeProfileDraftState.copyWith(
      homeName: action.newName,
    ),
  );
}

CreateHomeState _homeAddressChanged(
  CreateHomeState state,
  CreateHomeAddressChangedAction action,
) {
  return state.copyWith(
    homeProfileDraftState: state.homeProfileDraftState.copyWith(
      homeAddress: action.newAddress,
    ),
  );
}

CreateHomeState _homeAboutChanged(
  CreateHomeState state,
  CreateHomeAboutChangedAction action,
) {
  return state.copyWith(
    homeProfileDraftState: state.homeProfileDraftState.copyWith(
      homeAbout: action.newAbout,
    ),
  );
}

CreateHomeState _pickedHomeAvatar(
  CreateHomeState state,
  CreateHomeAvatarPickedAction action,
) {
  return state.copyWith(
    homeProfileDraftState: state.homeProfileDraftState.copyWith(
      homeAvatar: action.avatar,
    ),
  );
}

CreateHomeState _removeHomeAvatar(
  CreateHomeState state,
  RemoveCreateHomeAvatarAction action,
) {
  return state.copyWith(
    homeProfileDraftState: state.homeProfileDraftState.copyWith(
      homeAvatar: null,
    ),
  );
}

CreateHomeState _userNameChanged(
  CreateHomeState state,
  CreateHomeUserNameChangedAction action,
) {
  return state.copyWith(
    userProfileDraftState: state.userProfileDraftState.copyWith(
      userName: action.newName,
    ),
  );
}

CreateHomeState _userBioChanged(
  CreateHomeState state,
  CreateHomeUserBioChangedAction action,
) {
  return state.copyWith(
    userProfileDraftState: state.userProfileDraftState.copyWith(
      userBio: action.newBio,
    ),
  );
}

CreateHomeState _pickedUserAvatar(
  CreateHomeState state,
  CreateHomeUserAvatarPickedAction action,
) {
  return state.copyWith(
    userProfileDraftState: state.userProfileDraftState.copyWith(
      userAvatar: action.avatar,
    ),
  );
}

CreateHomeState _removeUserAvatar(
  CreateHomeState state,
  CreateHomeRemoveUserAvatarAction action,
) {
  return state.copyWith(
    userProfileDraftState: state.userProfileDraftState.copyWith(
      userAvatar: null,
    ),
  );
}

CreateHomeState _failedToPickAvatar(
  CreateHomeState state,
  CreateHomeFailedToPickAvatarAction action,
) {
  return state.copyWith(error: const CreateHomeError.failedToObtainPhoto());
}

CreateHomeState _createHome(
  CreateHomeState state,
  CreateHomeAction action,
) {
  return state.copyWith(
    isLoading: true,
  );
}

CreateHomeState _createHomeClosed(
  CreateHomeState state,
  CloseCreateHomeAction action,
) {
  return CreateHomeState.initial();
}

CreateHomeState _failedToCreateHome(
  CreateHomeState state,
  FailedToCreateHomeAction action,
) {
  return state.copyWith(
    error: const CreateHomeError.failedToCreate(),
    isLoading: false,
  );
}

CreateHomeState _errorProcessed(
  CreateHomeState state,
  CreateHomeErrorProcessedAction action,
) {
  return state.copyWith(
    error: null,
  );
}
