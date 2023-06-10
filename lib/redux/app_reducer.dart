import 'package:nestify/redux/add_member/add_member_reducer.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/create_home/create_home_reducer.dart';
import 'package:nestify/redux/home/home_reducer.dart';
import 'package:nestify/redux/home_profile/home_profile_reducer.dart';
import 'package:nestify/redux/join_home/join_home_reducer.dart';
import 'package:nestify/redux/login/login_reducer.dart';
import 'package:nestify/redux/scan_qr_code/scan_qr_code_reducer.dart';
import 'package:nestify/redux/settings/settings_reducer.dart';

AppState appReducer(AppState state, dynamic action) => state.copyWith(
      loginState: loginStateReducer(state.loginState, action),
      scanQrCodeState: scanQrCodeStateStateReducer(
        state.scanQrCodeState,
        action,
      ),
      createHomeState: createHomeStateReducer(state.createHomeState, action),
      settingsState: settingsStateReducer(state.settingsState, action),
      homeState: homeStateReducer(state.homeState, action),
      homeProfileState: homeProfileStateReducer(state.homeProfileState, action),
      addMemberState: addMemberStateReducer(state.addMemberState, action),
      joinHomeState: joinHomeStateReducer(state.joinHomeState, action),
    );
