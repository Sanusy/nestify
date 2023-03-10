import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_route.freezed.dart';

@freezed
class AppRoute with _$AppRoute {
  const AppRoute._();

  const factory AppRoute.login() = _Login;

  const factory AppRoute.rootTebBar() = _RootTebBar;

  bool get fullscreenDialog => maybeWhen(
        orElse: () => false,
      );
}
