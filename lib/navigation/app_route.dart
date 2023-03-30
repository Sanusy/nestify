import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_route.freezed.dart';

@freezed
class AppRoute with _$AppRoute {
  const AppRoute._();

  const factory AppRoute.login() = _Login;

  const factory AppRoute.homelessUser() = _HomelessUser;

  const factory AppRoute.createHome() = _CreateHome;

  const factory AppRoute.createUserProfile() = _CreateHUserProfile;

  const factory AppRoute.rootTebBar() = _RootTebBar;

  bool get fullscreenDialog => maybeWhen(
        orElse: () => false,
        createHome: () => true,
      );
}
