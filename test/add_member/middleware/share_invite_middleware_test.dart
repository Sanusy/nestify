import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nestify/redux/add_member/add_member_action.dart';
import 'package:nestify/redux/add_member/add_member_state.dart';
import 'package:nestify/redux/add_member/middleware/share_invite_middleware.dart';
import 'package:nestify/redux/app_reducer.dart';
import 'package:nestify/redux/app_state.dart';
import 'package:nestify/service/external_activities_service/external_activities_service.dart';

import '../../test_store.dart';

class MockExternalActivitiesService extends Mock
    implements ExternalActivitiesService {}

void main() {
  group(
    'Share home invite tests',
    () {
      late TestStore<AppState> store;
      late ExternalActivitiesService externalActivitiesService;
      late ShareInviteMiddleware middleware;
      late String inviteUrl;

      setUpAll(() {
        registerFallbackValue(XFile('dummy_path'));
      });

      setUp(() {
        inviteUrl = 'inviteUrl';
        externalActivitiesService = MockExternalActivitiesService();
        middleware = ShareInviteMiddleware(externalActivitiesService);
        store = TestStore<AppState>(
          appReducer,
          initialState: AppState.initial().copyWith(
            addMemberState: AddMemberState.initial().copyWith(
              inviteUrl: inviteUrl,
            ),
          ),
          middleware: [middleware],
        );
      });

      test('check image invite shared', () async {
        const inviteDescriptionText = 'Invite description';
        final inviteDescription =
            '$inviteDescriptionText ${store.state.addMemberState.inviteUrl}';

        final pictureBytes = Uint8List(1);

        when(() => externalActivitiesService.shareHomeInvite(
              inviteDescription: inviteDescription,
              qrCode: any(named: 'qrCode'),
            )).thenAnswer((_) => Future.value());

        await middleware.process(
          store,
          ShareInviteAction(
            pictureBytes: pictureBytes,
            inviteDescription: inviteDescriptionText,
          ),
        );

        verify(() => externalActivitiesService.shareHomeInvite(
              inviteDescription: inviteDescription,
              qrCode: any(named: 'qrCode'),
            )).called(1);
      });
    },
  );
}
