import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/navigation/implementation/routes.dart';
import 'package:nestify/service/snack_bar_service/snack_bar_service.dart';

class SnackBarServiceImplementation implements SnackBarService {
  final GlobalKey<ScaffoldMessengerState> _messengerKey;
  SnackBar? _queuedSnackBar;

  SnackBarServiceImplementation(this._messengerKey) {
    /// Used to be able to show SnackBar from the app initialization phase
    /// when there is no Scaffold available. If there is no Scaffold
    /// available, try to show SnackBar again after navigation.
    goRouter.addListener(() {
      if (_queuedSnackBar != null) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          _messengerKey.currentState?.showSnackBar(_queuedSnackBar!);
          _queuedSnackBar = null;
        });
      }
    });
  }

  @override
  void showJoinHomeError() {
    final context = _messengerKey.currentContext;
    if (context != null) {
      final localization = AppLocalizations.of(context)!;
      _showSnackBar(localization.dynamicLinkFailedToOpenInvite);
    }
  }

  @override
  void showInvalidInviteError() {
    final context = _messengerKey.currentContext;
    if (context != null) {
      final localization = AppLocalizations.of(context)!;
      _showSnackBar(localization.dynamicLinkInvalidUrl);
    }
  }

  @override
  void showAlreadyHomeMemberSnackBar() {
    final context = _messengerKey.currentContext;
    if (context != null) {
      final localization = AppLocalizations.of(context)!;
      _showSnackBar(localization.dynamicLinkAlreadyHomeMember);
    }
  }

  @override
  void showFailedToObtainPhoto() {
    final context = _messengerKey.currentContext;
    if (context != null) {
      final localization = AppLocalizations.of(context)!;
      _showSnackBar(localization.commonFailedToObtainPhoto);
    }
  }

  @override
  void showCommonError() {
    final context = _messengerKey.currentContext;
    if (context != null) {
      final localization = AppLocalizations.of(context)!;
      _showSnackBar(localization.commonError);
    }
  }

  void _showSnackBar(String content) {
    final snackBar = SnackBar(
      content: Text(content),
      behavior: SnackBarBehavior.floating,
    );
    try {
      _messengerKey.currentState?.showSnackBar(snackBar);
    } catch (_) {
      _queuedSnackBar = snackBar;
    }
  }
}
