import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:nestify/redux/add_member/add_member_action.dart';
import 'package:nestify/redux/add_member/add_member_state.dart';
import 'package:nestify/redux/app_reducer.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:redux/redux.dart';

void main() {
  group('add member reducers tests', () {
    late Store<AppState> store;

    setUp(() {
      store = Store<AppState>(appReducer, initialState: AppState.initial());
    });

    test('when obtaining invite url, loading is true and error is null', () {
      store.dispatch(ObtainInviteUrlAction());

      expect(
        store.state.addMemberState.isLoading,
        isTrue,
      );
      expect(store.state.addMemberState.error, isNull);
    });

    test(
        'when url obtained, loading is false, no error and correct invite url set',
        () {
      const inviteUrl = 'obtained invite url';
      store.dispatch(InviteUrlObtainedAction(inviteUrl: inviteUrl));

      expect(store.state.addMemberState.isLoading, isFalse);
      expect(store.state.addMemberState.error, isNull);
      expect(store.state.addMemberState.inviteUrl, inviteUrl);
    });

    test('when failed to obtain invite url, loading is false and error in set',
        () {
      store.dispatch(FailedToObtainInviteUrlAction());

      expect(store.state.addMemberState.isLoading, isFalse);
      expect(
        store.state.addMemberState.error,
        const AddMemberError.obtainInviteUrl(),
      );
    });

    test('create invite picture sets loading state', () {
      store.dispatch(CreateInvitePictureAction());

      expect(store.state.addMemberState.isInviteCapturingInProgress, isTrue);
    });

    test('on share invite resets loading state to false', () {
      store.dispatch(ShareInviteAction(
        pictureBytes: Uint8List(1),
        inviteDescription: 'invite Description',
      ));

      expect(store.state.addMemberState.isInviteCapturingInProgress, isFalse);
    });
  });
}
