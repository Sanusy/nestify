import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_route.freezed.dart';

@freezed
class AppRoute with _$AppRoute {
  const AppRoute._();

  const factory AppRoute.first() = _First;

  const factory AppRoute.second() = _Second;

  const factory AppRoute.third() = _Third;

  bool get fullscreenDialog => maybeWhen(
        orElse: () => false,
        third: () => true,
      );
}
