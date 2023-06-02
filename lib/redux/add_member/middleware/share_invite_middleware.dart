import 'package:image_picker/image_picker.dart';
import 'package:nestify/redux/add_member/add_member_action.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/common_middlewares/base_middleware.dart';
import 'package:nestify/service/external_activities_service/external_activities_service.dart';
import 'package:redux/redux.dart';

final class ShareInviteMiddleware extends BaseMiddleware<ShareInviteAction> {
  final ExternalActivitiesService _externalActivitiesService;

  ShareInviteMiddleware(
    this._externalActivitiesService,
  );

  @override
  Future<void> process(
    Store<AppState> store,
    ShareInviteAction action,
  ) async {
    final picture = XFile.fromData(
      action.pictureBytes,
      mimeType: 'image/png',
    );

    await _externalActivitiesService.shareHomeInvite(
      inviteDescription:
          '${action.inviteDescription} ${store.state.addMemberState.inviteUrl!}',
      qrCode: picture,
    );
  }
}
