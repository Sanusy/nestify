import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/common_middlewares/base_middleware.dart';
import 'package:nestify/redux/home_profile/home_profile_action.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/service/file_error.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:nestify/service/snack_bar_service/snack_bar_service.dart';
import 'package:redux/redux.dart';

final class DeleteHomeMiddleware extends BaseMiddleware<DeleteHomeAction> {
  final HomeService _homeService;
  final SnackBarService _snackBarService;

  DeleteHomeMiddleware(
    this._homeService,
    this._snackBarService,
  );

  @override
  Future<void> process(
    Store<AppState> store,
    DeleteHomeAction action,
  ) async {
    try {
      await _homeService.deleteHome(homeToDelete: store.state.homeState.home!);

      store.dispatch(SetPathNavigationAction(HomelessUserRoute()));
      store.dispatch(HomeDeletedAction());
    } on NetworkError {
      _snackBarService.showCommonError();
    } on FileError {
      debugPrint('Failed to clean storage after home delete');
    }
  }
}
