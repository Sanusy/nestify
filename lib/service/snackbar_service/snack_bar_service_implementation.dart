import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/service/snackbar_service/snack_bar_service.dart';

class SnackBarServiceImplementation implements SnackBarService {
  final GlobalKey<ScaffoldMessengerState> _messengerKey;

  SnackBarServiceImplementation(this._messengerKey);

  @override
  void showJoinHomeError() {
    final context = _messengerKey.currentState?.context;
    if (context != null) {
      final localization = AppLocalizations.of(context)!;
      _showSnackBar(localization.commonError);
    }
  }

  void _showSnackBar(String content) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _messengerKey.currentState
          ?.showSnackBar(SnackBar(content: Text(content)));
    });
  }
}
