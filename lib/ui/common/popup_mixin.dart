import 'package:flutter/material.dart';
import 'package:nestify/ui/command.dart';
import 'package:nestify/ui/common/quit_confirmation_dialog/quit_confirmation_dialog.dart';
import 'package:nestify/ui/common/quit_confirmation_dialog/quit_confirmation_dialog_view_model.dart';

mixin PopupMixin {
  void showSnackBar(
    BuildContext context,
    String content,
    Command? onProcessed,
  ) {
    ScaffoldMessenger.maybeOf(context)
        ?.showSnackBar(SnackBar(content: Text(content)));
    onProcessed?.command();
  }

  void showQuitConfirmationDialog(
    BuildContext context,
    QuitConfirmationDialogViewModel viewModel,
  ) {
    showDialog(
      context: context,
      builder: (_) => QuitConfirmationDialog(
        viewModel: viewModel,
      ),
    );
  }
}
