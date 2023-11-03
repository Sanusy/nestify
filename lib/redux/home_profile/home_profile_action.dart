import 'package:nestify/models/nestify_user.dart';

class DeleteHomeAction {}

class LeavedHomeAction {}

class FailedToDeleteHomeAction {}

class SelectNewAdminAction {
  final NestifyUser newAdmin;

  SelectNewAdminAction(this.newAdmin);
}

class ClosedLeaveHomeDialogAction {}

class LeaveHomeAction {}

class FailedToLeaveHomeAction {}
