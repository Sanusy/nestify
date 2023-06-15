import 'package:nestify/models/user.dart';

class DeleteHomeAction {}

class LeavedHomeAction {}

class FailedToDeleteHomeAction {}

class SelectNewAdminAction {
  final User newAdmin;

  SelectNewAdminAction(this.newAdmin);
}

class ClosedLeaveHomeDialogAction {}

class LeaveHomeAction {}

class FailedToLeaveHomeAction {}
