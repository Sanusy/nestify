import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/common/popup_mixin.dart';
import 'package:nestify/ui/my_profile/my_profile_view_model.dart';

final class MyProfileScreen extends StatelessWidget with PopupMixin {
  final MyProfileViewModel viewModel;

  const MyProfileScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return WillPopScope(
      onWillPop: () async {
        switch (viewModel) {
          case MyProfileBodyViewModel(
                quitConfirmation: final quitConfirmationViewModel,
              )
              when quitConfirmationViewModel != null:
            showQuitConfirmationDialog(context, quitConfirmationViewModel);
            return false;
          default:
            return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(localization.myProfileScreenTitle),
        ),
        body: Center(
          child: Text(localization.myProfileScreenTitle),
        ),
      ),
    );
  }
}
