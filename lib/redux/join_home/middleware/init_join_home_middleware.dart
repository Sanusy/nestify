import 'dart:async';

import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/join_home/join_home_action.dart';
import 'package:nestify/redux/middleware/base_middleware.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:redux/redux.dart';

final class InitJoinHomeMiddleware extends BaseMiddleware<InitJoinHomeAction> {
  final HomeService _homeService;

  InitJoinHomeMiddleware(
    this._homeService,
  );

  @override
  Future<void> process(
    Store<AppState> store,
    InitJoinHomeAction action,
  ) async {
    try {
      final colors = await _homeService.availableColors();
      final users = await _homeService.homeUsers(action.homeToJoin.usersIds);

      store.dispatch(JoinHomeInitializedAction(
        colors: colors,
        users: users,
      ));
    } on NetworkError {
      store.dispatch(FailedToInitJoinHomeAction());
    }
  }
}
