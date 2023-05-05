import 'package:nestify/models/home.dart';
import 'package:nestify/models/user.dart';
import 'package:nestify/models/user_color.dart';

class InitJoinHomeAction {
  final Home homeToJoin;

  InitJoinHomeAction({required this.homeToJoin});
}

class JoinHomeInitializedAction {
  final List<UserColor> colors;
  final List<User> users;

  JoinHomeInitializedAction({
    required this.colors,
    required this.users,
  });
}

class FailedToInitJoinHomeAction {}

class JoinHomeAction {}
