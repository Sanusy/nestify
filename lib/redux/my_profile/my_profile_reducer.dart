import 'package:nestify/redux/my_profile/my_profile_action.dart';
import 'package:nestify/redux/my_profile/my_profile_state.dart';
import 'package:redux/redux.dart';

final myProfileStateReducer = combineReducers<MyProfileState>([
  TypedReducer(_initMyProfile),
  TypedReducer(_closeMyProfile),
  TypedReducer(_pickedProfileAvatar),
  TypedReducer(_removeProfileAvatar),
  TypedReducer(_myProfileNameChanged),
  TypedReducer(_myProfileBioChanged),
  TypedReducer(_myProfileColorChanged),
  TypedReducer(_editMyProfile),
  TypedReducer(_myProfileEdited),
  TypedReducer(_failedToMyProfile),
]);

MyProfileState _initMyProfile(
  MyProfileState state,
  InitMyProfileAction action,
) {
  return state.copyWith(
    initialProfile: action.myProfile,
    editedProfile: action.myProfile,
    isLoading: false,
  );
}

MyProfileState _closeMyProfile(
  MyProfileState state,
  CloseMyProfileAction action,
) {
  return MyProfileState.initial();
}

MyProfileState _pickedProfileAvatar(
  MyProfileState state,
  MyProfileAvatarPickedAction action,
) {
  return state.copyWith(
    pickedAvatar: action.pickedAvatar,
  );
}

MyProfileState _removeProfileAvatar(
  MyProfileState state,
  RemoveMyProfileAvatarAction action,
) {
  return state.copyWith(
    editedProfile: state.editedProfile?.copyWith(
      avatarUrl: null,
    ),
    pickedAvatar: null,
  );
}

MyProfileState _myProfileNameChanged(
  MyProfileState state,
  MyProfileNameChangedAction action,
) {
  return state.copyWith(
    editedProfile: state.editedProfile?.copyWith(
      userName: action.newName,
    ),
  );
}

MyProfileState _myProfileBioChanged(
  MyProfileState state,
  MyProfileBioChangedAction action,
) {
  return state.copyWith(
    editedProfile: state.editedProfile?.copyWith(
      bio: action.newBio,
    ),
  );
}

MyProfileState _myProfileColorChanged(
  MyProfileState state,
  MyProfileColorChangedAction action,
) {
  return state.copyWith(
    editedProfile: state.editedProfile?.copyWith(
      colorId: action.newColor.id,
    ),
  );
}

MyProfileState _editMyProfile(
  MyProfileState state,
  EditMyProfileAction action,
) {
  return state.copyWith(
    isLoading: true,
  );
}

MyProfileState _myProfileEdited(
  MyProfileState state,
  MyProfileEditedAction action,
) {
  return state.copyWith(
    isLoading: false,
    pickedAvatar: null,
    initialProfile: action.editedUser,
    editedProfile: action.editedUser,
  );
}

MyProfileState _failedToMyProfile(
  MyProfileState state,
  FailedToEditMyProfileAction action,
) {
  return state.copyWith(
    isLoading: false,
  );
}
