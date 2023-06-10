import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nestify/redux/add_member/add_member_state.dart';
import 'package:nestify/redux/create_home/create_home_state.dart';
import 'package:nestify/redux/home/home_state.dart';
import 'package:nestify/redux/home_profile/home_profile_state.dart';
import 'package:nestify/redux/join_home/join_home_state.dart';
import 'package:nestify/redux/login/login_state.dart';
import 'package:nestify/redux/scan_qr_code/scan_qr_code_state.dart';
import 'package:nestify/redux/settings/settings_state.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    required LoginState loginState,
    required ScanQrCodeState scanQrCodeState,
    required CreateHomeState createHomeState,
    required SettingsState settingsState,
    required HomeState homeState,
    required HomeProfileState homeProfileState,
    required AddMemberState addMemberState,
    required JoinHomeState joinHomeState,
  }) = _AppState;

  factory AppState.initial() => AppState(
        loginState: LoginState.initial(),
        scanQrCodeState: ScanQrCodeState.initial(),
        createHomeState: CreateHomeState.initial(),
        settingsState: SettingsState.initial(),
        homeState: HomeState.initial(),
        homeProfileState: HomeProfileState.initial(),
        addMemberState: AddMemberState.initial(),
        joinHomeState: JoinHomeState.initial(),
      );
}
