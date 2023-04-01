import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/create_home/create_home_action.dart';
import 'package:nestify/redux/middleware/base_middleware.dart';
import 'package:nestify/service/file_error.dart';
import 'package:nestify/service/file_service/file_service.dart';
import 'package:nestify/service/home_service/home_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:nestify/service/user_service/user_service.dart';
import 'package:redux/redux.dart';

class CreateHomeMiddleware extends BaseMiddleware<CreateHomeAction> {
  final HomeService _homeService;
  final FileService _fileService;
  final UserService _userService;

  CreateHomeMiddleware(
    this._homeService,
    this._fileService,
    this._userService,
  );

  @override
  Future<void> process(
    Store<AppState> store,
    CreateHomeAction action,
  ) async {
    try {} on NetworkError {
      store.dispatch(FailedToCreateHomeAction());
    } on FileError {
      store.dispatch(FailedToCreateHomeAction());
    }
  }
}
