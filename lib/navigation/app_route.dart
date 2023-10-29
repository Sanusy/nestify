sealed class AppRoute {
  bool get fullscreenDialog => false;

  @override
  bool operator ==(Object other) {
    return runtimeType == other.runtimeType;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

final class SplashRoute extends AppRoute {}

class LoginRoute extends AppRoute {}

class HomelessUserRoute extends AppRoute {}

class JoinHomeRoute extends AppRoute {
  @override
  bool get fullscreenDialog => true;
}

class CreateHomeRoute extends AppRoute {
  @override
  bool get fullscreenDialog => true;
}

class HomeRoute extends AppRoute {}

class HomeProfileRoute extends AppRoute {}

class SettingsRoute extends AppRoute {}

class AddMemberRoute extends AppRoute {}

class ScanQrCodeRoute extends AppRoute {}

class EditHomeRoute extends AppRoute {
  @override
  bool get fullscreenDialog => true;
}
