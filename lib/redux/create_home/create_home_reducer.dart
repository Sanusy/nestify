import 'package:nestify/redux/create_home/create_home_action.dart';
import 'package:nestify/redux/create_home/create_home_state.dart';
import 'package:redux/redux.dart';

final createHomeStateReducer = combineReducers<CreateHomeState>([
  TypedReducer(_homeNameChanged),
  TypedReducer(_homeAddressChanged),
  TypedReducer(_homeAboutChanged),
  TypedReducer(_pickedHomeAvatar),
  TypedReducer(_removeHomeAvatar),
  TypedReducer(_failedToPickAvatar),
  TypedReducer(_createHome),
  TypedReducer(_homeCreated),
  TypedReducer(_failedToCreateHome),
  TypedReducer(_errorProcessed),
]);

CreateHomeState _homeNameChanged(
  CreateHomeState state,
  HomeNameChangedAction action,
) {
  return state.copyWith(homeName: action.newName);
}

CreateHomeState _homeAddressChanged(
  CreateHomeState state,
  HomeAddressChangedAction action,
) {
  return state.copyWith(homeAddress: action.newAddress);
}

CreateHomeState _homeAboutChanged(
  CreateHomeState state,
  HomeAboutChangedAction action,
) {
  return state.copyWith(about: action.newAbout);
}

CreateHomeState _pickedHomeAvatar(
  CreateHomeState state,
  CreateHomeAvatarPickedAction action,
) {
  return state.copyWith(avatar: action.avatar);
}

CreateHomeState _removeHomeAvatar(
  CreateHomeState state,
  RemoveCreateHomeAvatarAction action,
) {
  return state.copyWith(avatar: null);
}

CreateHomeState _failedToPickAvatar(
  CreateHomeState state,
  FailedToPickCreateHomeAvatarAction action,
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

CreateHomeState _homeCreated(
  CreateHomeState state,
  HomeCreatedAction action,
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
