import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/common_middlewares/base_middleware.dart';
import 'package:nestify/redux/edit_home/edit_home_action.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/service/file_error.dart';
import 'package:nestify/service/file_service/file_service.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:nestify/service/snack_bar_service/snack_bar_service.dart';
import 'package:redux/redux.dart';

final class EditHomeMiddleware extends BaseMiddleware<EditHomeAction> {
  final HomeService _homeService;
  final FileService _fileService;
  final SnackBarService _snackBarService;

  EditHomeMiddleware(
    this._homeService,
    this._fileService,
    this._snackBarService,
  );

  @override
  Future<void> process(
    Store<AppState> store,
    EditHomeAction action,
  ) async {
    final editHomeState = store.state.editHomeState;
    final homeToEdit = editHomeState.editedHome;

    if (homeToEdit == null) return;

    try {
      final editedHome = await _homeService.editHome(
        homeToEdit: homeToEdit,
        newAvatar: editHomeState.pickedAvatar,
      );

      // TODO: Consider removing it to Cloud functions when they are available
      if (editHomeState.initialHome?.avatarUrl != null &&
          editHomeState.initialHome?.avatarUrl != editedHome.avatarUrl) {
        _removeOldAvatar(editHomeState.initialHome!.avatarUrl!);
      }

      store.dispatch(HomeEditedAction(editedHome));
      store.dispatch(const PopNavigationAction());
    } on NetworkError {
      _failedToEditHome(store);
    } on FileError {
      _failedToEditHome(store);
    }
  }

  Future<void> _removeOldAvatar(String avatarUrl) async {
    try {
      await _fileService.removePicture(avatarUrl);
    } on FileError {
      debugPrint('Failed to remove old avatar from storage');
    }
  }

  void _failedToEditHome(Store<AppState> store) {
    _snackBarService.showCommonError();
    store.dispatch(FailedToEditHomeAction());
  }
}
