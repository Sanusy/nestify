import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_route.freezed.dart';

@freezed
class AppRoute with _$AppRoute {
  const AppRoute._();

  const factory AppRoute.splash() = _Splash;

  const factory AppRoute.login() = _Login;

  const factory AppRoute.homelessUser() = _HomelessUser;

  const factory AppRoute.homeToJoin() = _HomeToJoin;

  const factory AppRoute.createHome() = _CreateHome;

  const factory AppRoute.home() = _Home;

  const factory AppRoute.homeProfile() = _HomeProfile;

  const factory AppRoute.settings() = _Settings;

  const factory AppRoute.addMember() = _AddMember;

  bool get fullscreenDialog => maybeWhen(
        orElse: () => false,
        createHome: () => true,
        homeToJoin: () => true,
      );
}
