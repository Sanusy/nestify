import 'package:nestify/redux/create_user_profile/create_user_profile_action.dart';
import 'package:nestify/redux/create_user_profile/create_user_profile_state.dart';
import 'package:redux/redux.dart';

final createUserProfileStateReducer = combineReducers<CreateUserProfileState>([
  TypedReducer(_nameChanged),
  TypedReducer(_bioChanged),
  TypedReducer(_pickedUserAvatar),
  TypedReducer(_removeUserAvatar),
  TypedReducer(_failedToPickAvatar),
  TypedReducer(_errorProcessed),
]);

CreateUserProfileState _nameChanged(
  CreateUserProfileState state,
  UserNameChangedAction action,
) {
  return state.copyWith(name: action.newName);
}

CreateUserProfileState _bioChanged(
  CreateUserProfileState state,
  BioChangedAction action,
) {
  return state.copyWith(bio: action.newBio);
}

CreateUserProfileState _pickedUserAvatar(
  CreateUserProfileState state,
  CreateUserProfileAvatarPickedAction action,
) {
  return state.copyWith(avatar: action.avatar);
}

CreateUserProfileState _removeUserAvatar(
  CreateUserProfileState state,
  RemoveCreateUserProfileAvatarAction action,
) {
  return state.copyWith(avatar: null);
}

CreateUserProfileState _failedToPickAvatar(
  CreateUserProfileState state,
  FailedToPickCreateUserProfileAvatarAction action,
) {
  return state.copyWith(
      error: const CreateUserProfileError.failedToObtainPhoto());
}

CreateUserProfileState _errorProcessed(
  CreateUserProfileState state,
  CreateUserProfileErrorProcessedAction action,
) {
  return state.copyWith(
    error: null,
  );
}
