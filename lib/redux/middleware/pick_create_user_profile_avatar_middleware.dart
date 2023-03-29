import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/create_user_profile/create_user_profile_action.dart';
import 'package:nestify/redux/middleware/base_middleware.dart';
import 'package:nestify/service/file_error.dart';
import 'package:nestify/service/file_service/file_service.dart';
import 'package:redux/redux.dart';

class PickCreateUserProfileAvatarMiddleware
    extends BaseMiddleware<PickCreateUserProfileAvatarAction> {
  final FileService _fileService;

  PickCreateUserProfileAvatarMiddleware(
    this._fileService,
  );

  @override
  Future<void> process(
    Store<AppState> store,
    PickCreateUserProfileAvatarAction action,
  ) async {
    try {
      final avatar = await _fileService.pictureFromGallery();

      if (avatar != null) {
        store.dispatch(CreateUserProfileAvatarPickedAction(avatar));
      }
    } on FileError catch (_) {
      store.dispatch(FailedToPickCreateUserProfileAvatarAction());
    }
  }
}
