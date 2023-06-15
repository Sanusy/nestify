import 'package:nestify/models/user.dart';

class DeleteHomeAction {}

class HomeDeletedAction {}

class FailedToDeleteHomeAction {}

class SelectNewAdminAction {
  final User newAdmin;

  SelectNewAdminAction(this.newAdmin);
}

class ClosedLeaveHomeDialogAction {}

class LeaveHomeAction {}

class LeavedHomeAction {}

class FailedToLeaveHomeAction {}
