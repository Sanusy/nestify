import 'package:nestify/navigation/app_route.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/create_home/create_home_action.dart';
import 'package:nestify/redux/middleware/base_middleware.dart';
import 'package:nestify/redux/navigation/navigation_action.dart';
import 'package:nestify/service/file_error.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:redux/redux.dart';

class CreateHomeMiddleware extends BaseMiddleware<CreateHomeAction> {
  final HomeService _homeService;

  CreateHomeMiddleware(
    this._homeService,
  );

  @override
  Future<void> process(
    Store<AppState> store,
    CreateHomeAction action,
  ) async {
    try {
      final createHomeState = store.state.createHomeState;

      await _homeService.createHome(
        homeDraft: createHomeState.homeProfileDraftState,
        userDraft: createHomeState.userProfileDraftState,
      );

      store.dispatch(const NavigationAction.setPath(AppRoute.home()));
    } on NetworkError {
      store.dispatch(FailedToCreateHomeAction());
    } on FileError {
      store.dispatch(FailedToCreateHomeAction());
    }
  }
}