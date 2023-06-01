import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/join_home/join_home_action.dart';
import 'package:nestify/redux/middleware/base_middleware.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/service/file_error.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:nestify/service/snack_bar_service/snack_bar_service.dart';
import 'package:redux/redux.dart';

final class JoinHomeMiddleware extends BaseMiddleware<JoinHomeAction> {
  final HomeService _homeService;
  final SnackBarService _snackBarService;

  JoinHomeMiddleware(
    this._homeService,
    this._snackBarService,
  );

  @override
  Future<void> process(
    Store<AppState> store,
    JoinHomeAction action,
  ) async {
    try {
      final joinHomeState = store.state.joinHomeState;

      await _homeService.joinHome(
        homeId: joinHomeState.homeToJoin!.id,
        userDraft: joinHomeState.userProfileDraftState,
      );

      store.dispatch(SetPathNavigationAction(HomeRoute()));
    } on NetworkError {
      _snackBarService.showCommonError();
      store.dispatch(FailedToJoinHomeAction());
    } on FileError {
      _snackBarService.showCommonError();
      store.dispatch(FailedToJoinHomeAction());
    }
  }
}
