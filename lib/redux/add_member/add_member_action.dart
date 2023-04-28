import 'dart:typed_data';

class ObtainInviteUrlAction {}

class FailedToObtainInviteUrlAction {}

class InviteUrlObtainedAction {
  final String inviteUrl;

  InviteUrlObtainedAction({required this.inviteUrl});
}

class CreateInvitePictureAction {}

class ShareInviteAction {
  final Uint8List pictureBytes;
  final String inviteDescription;

  ShareInviteAction({
    required this.pictureBytes,
    required this.inviteDescription,
  });
}
