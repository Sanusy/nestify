import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/create_home/create_home_action.dart';
import 'package:nestify/redux/middleware/base_middleware.dart';
import 'package:nestify/service/file_error.dart';
import 'package:nestify/service/file_service/file_service.dart';
import 'package:redux/redux.dart';

class PickCreateHomeAvatarMiddleware
    extends BaseMiddleware<PickCreateHomeAvatarAction> {
  final FileService _fileService;

  PickCreateHomeAvatarMiddleware(
    this._fileService,
  );

  @override
  Future<void> process(
    Store<AppState> store,
    PickCreateHomeAvatarAction action,
  ) async {
    try {
      final avatar = await _fileService.pictureFromGallery();

      if (avatar != null) {
        store.dispatch(CreateHomeAvatarPickedAction(avatar));
      }
    } on FileError catch (_) {
      store.dispatch(FailedToPickCreateHomeAvatarAction());
    }
  }
}
