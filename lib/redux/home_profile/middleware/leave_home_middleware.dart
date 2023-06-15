import 'dart:async';

import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/common_middlewares/base_middleware.dart';
import 'package:nestify/redux/home_profile/home_profile_action.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:nestify/service/snack_bar_service/snack_bar_service.dart';
import 'package:redux/redux.dart';

final class LeaveHomeMiddleware extends BaseMiddleware<LeaveHomeAction> {
  final HomeService _homeService;
  final SnackBarService _snackBarService;

  LeaveHomeMiddleware(
    this._homeService,
    this._snackBarService,
  );

  @override
  Future<void> process(
    Store<AppState> store,
    LeaveHomeAction action,
  ) async {
    final homeId = store.state.homeState.home!.id;
    final newAdminId =
        store.state.homeProfileState.leaveHomeState?.newAdmin?.id;

    try {
      await _homeService.leaveHome(
        homeId: homeId,
        newAdminId: newAdminId,
      );

      store.dispatch(SetPathNavigationAction(HomelessUserRoute()));
      store.dispatch(LeavedHomeAction());
    } on NetworkError {
      _snackBarService.showCommonError();
      store.dispatch(FailedToLeaveHomeAction());
    }
  }
}
