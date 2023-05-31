import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/create_home/create_home_action.dart';
import 'package:nestify/redux/middleware/base_middleware.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:redux/redux.dart';

final class LoadAvailableColorsMiddleware
    extends BaseMiddleware<LoadAvailableColorsAction> {
  final HomeService _homeService;

  LoadAvailableColorsMiddleware(
    this._homeService,
  );

  @override
  Future<void> process(
    Store<AppState> store,
    LoadAvailableColorsAction action,
  ) async {
    try {
      final availableColors = await _homeService.availableColors();

      store.dispatch(LoadedAvailableColorsAction(availableColors));
    } on NetworkError {
      store.dispatch(FailedToLoadAvailableColorsAction());
    }
  }
}
