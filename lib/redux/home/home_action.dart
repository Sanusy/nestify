import 'package:nestify/models/home.dart';
import 'package:nestify/models/user.dart';
import 'package:nestify/models/user_color.dart';

class InitHomeAction {}

class FailedToInitHomeAction {}

class HomeInitializedAction {
  final String currentUserId;
  final List<UserColor> colors;
  final Home home;
  final List<User> users;

  HomeInitializedAction({
    required this.currentUserId,
    required this.colors,
    required this.home,
    required this.users,
  });
}
