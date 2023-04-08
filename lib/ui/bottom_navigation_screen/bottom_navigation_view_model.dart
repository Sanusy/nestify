import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/ui/bottom_navigation_screen/bottom_navigation_destinations.dart';
import 'package:nestify/ui/command.dart';

part 'bottom_navigation_view_model.freezed.dart';

@Freezed(copyWith: false)
class BottomNavigationViewModel with _$BottomNavigationViewModel {
  const factory BottomNavigationViewModel({
    required Widget currentScreen,
    required CommandWith<BottomNavigationDestination> onSelectDestination,
  }) = _BottomNavigationViewModel;
}
