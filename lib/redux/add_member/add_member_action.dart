class ObtainInviteUrlAction {}

class FailedToObtainInviteUrlAction {}

class InviteUrlObtainedAction {
  final String inviteUrl;

  InviteUrlObtainedAction({required this.inviteUrl});
}

class AddMemberErrorProcessedAction {}
