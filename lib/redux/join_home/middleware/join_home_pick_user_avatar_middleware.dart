import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/join_home/join_home_action.dart';
import 'package:nestify/redux/middleware/base_middleware.dart';
import 'package:nestify/service/file_error.dart';
import 'package:nestify/service/file_service/file_service.dart';
import 'package:nestify/service/snack_bar_service/snack_bar_service.dart';
import 'package:redux/redux.dart';

final class JoinHomePickUserAvatarMiddleware
    extends BaseMiddleware<JoinHomePickUserAvatarAction> {
  final FileService _fileService;
  final SnackBarService _snackBarService;

  JoinHomePickUserAvatarMiddleware(
    this._fileService,
    this._snackBarService,
  );

  @override
  Future<void> process(
    Store<AppState> store,
    JoinHomePickUserAvatarAction action,
  ) async {
    try {
      final avatar = await _fileService.pictureFromGallery();

      if (avatar != null) {
        store.dispatch(JoinHomeUserAvatarPickedAction(avatar));
      }
    } on FileError catch (_) {
      _snackBarService.showFailedToObtainPhoto();
    }
  }
}
