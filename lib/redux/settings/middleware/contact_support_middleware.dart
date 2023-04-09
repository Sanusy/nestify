import 'package:nestify/redux/app_state.dart';
import 'package:nestify/redux/middleware/base_middleware.dart';
import 'package:nestify/redux/settings/settings_action.dart';
import 'package:nestify/service/constants_service/constants_service.dart';
import 'package:nestify/service/external_activities_service/external_activities_service.dart';
import 'package:nestify/service/network_error.dart';
import 'package:redux/redux.dart';

class ContactSupportMiddleware extends BaseMiddleware<ContactSupportAction> {
  final ConstantsService _constantsService;
  final ExternalActivitiesService _externalActivitiesService;

  ContactSupportMiddleware(
    this._constantsService,
    this._externalActivitiesService,
  );

  @override
  Future<void> process(
    Store<AppState> store,
    ContactSupportAction action,
  ) async {
    try {
      final supportEmail = await _constantsService.supportEmail();
      await _externalActivitiesService.mainTo(supportEmail);
      store.dispatch(ContactSupportOpenedAction());
    } on NetworkError {
      store.dispatch(FailedToContactSupportAction());
    }
  }
}
