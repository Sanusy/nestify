import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/common/quit_confirmation_dialog/quit_confirmation_dialog_view_model.dart';

class QuitConfirmationDialog extends StatelessWidget {
  final QuitConfirmationDialogViewModel viewModel;

  const QuitConfirmationDialog({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return AlertDialog(
      contentPadding: const EdgeInsets.all(24),
      content: Text(localization.commonQuitConfirmation),
      actions: [
        TextButton(
          onPressed: viewModel.onQuit,
          child: Text(localization.commonQuit),
        ),
        TextButton(
          onPressed: viewModel.onStay,
          child: Text(localization.commonStay),
        ),
      ],
    );
  }
}
