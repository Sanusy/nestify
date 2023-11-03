import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/common_middlewares/base_middleware.dart';
import 'package:nestify/redux/my_profile/my_profile_action.dart';
import 'package:nestify/service/file_error.dart';
import 'package:nestify/service/file_service/file_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:nestify/service/snack_bar_service/snack_bar_service.dart';
import 'package:nestify/service/user_service/user_service.dart';
import 'package:redux/redux.dart';

final class EditMyProfileMiddleware
    extends BaseMiddleware<EditMyProfileAction> {
  final UserService _userService;
  final FileService _fileService;
  final SnackBarService _snackBarService;

  EditMyProfileMiddleware(
    this._userService,
    this._fileService,
    this._snackBarService,
  );

  @override
  Future<void> process(
    Store<AppState> store,
    EditMyProfileAction action,
  ) async {
    final myProfileState = store.state.myProfileState;
    final profileToUpdate = myProfileState.editedProfile;

    if (profileToUpdate == null) return;

    try {
      final editedProfile = await _userService.editMyProfile(
        updatedProfile: profileToUpdate,
        newAvatar: myProfileState.pickedAvatar,
      );

      // TODO: Consider removing it to Cloud functions when they are available
      if (myProfileState.initialProfile?.avatarUrl != null &&
          myProfileState.initialProfile?.avatarUrl != editedProfile.avatarUrl) {
        _removeOldAvatar(myProfileState.initialProfile!.avatarUrl!);
      }

      store.dispatch(MyProfileEditedAction(editedProfile));
    } on NetworkError {
      _failedToEditProfile(store);
    } on FileError {
      _failedToEditProfile(store);
    }
  }

  Future<void> _removeOldAvatar(String avatarUrl) async {
    try {
      await _fileService.removePicture(avatarUrl);
    } on FileError {
      debugPrint('Failed to remove old avatar from storage');
    }
  }

  void _failedToEditProfile(Store<AppState> store) {
    _snackBarService.showCommonError();
    store.dispatch(FailedToEditMyProfileAction());
  }
}
