import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/common_middlewares/base_middleware.dart';
import 'package:nestify/redux/edit_home/edit_home_action.dart';
import 'package:nestify/service/file_error.dart';
import 'package:nestify/service/file_service/file_service.dart';
import 'package:nestify/service/snack_bar_service/snack_bar_service.dart';
import 'package:redux/redux.dart';

final class EditHomePickHomeAvatarMiddleware
    extends BaseMiddleware<EditHomePickHomeAvatarAction> {
  final FileService _fileService;
  final SnackBarService _snackBarService;

  EditHomePickHomeAvatarMiddleware(
    this._fileService,
    this._snackBarService,
  );

  @override
  Future<void> process(
    Store<AppState> store,
    EditHomePickHomeAvatarAction action,
  ) async {
    try {
      final avatar = await _fileService.pictureFromGallery();

      if (avatar != null) {
        store.dispatch(EditHomeAvatarPickedAction(avatar));
      }
    } on FileError catch (_) {
      _snackBarService.showFailedToObtainPhoto();
    }
  }
}
