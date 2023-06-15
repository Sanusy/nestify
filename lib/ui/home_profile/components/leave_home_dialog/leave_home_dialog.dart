import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/home_profile/components/leave_home_dialog/leave_home_dialog_view_model.dart';
import 'package:nestify/ui/home_profile/components/leave_home_dialog/select_admin_tile.dart';

class LeaveHomeDialog extends StatelessWidget {
  final LeaveHomeDialogViewModel viewModel;

  const LeaveHomeDialog({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(localization.homeProfileLeaveDialogTitle),
      content: viewModel.when(
        user: (_, __) => Text(
          localization.homeProfileLeaveDialogUserDescription,
        ),
        admin: (newAdminName, _, __) => Text(
          localization.homeProfileLeaveDialogAdminSingleUserDescription(
            newAdminName,
          ),
        ),
        adminWithUsers: (potentialAdmins, _, __) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localization.homeProfileLeaveDialogMultipleUsersDescription,
            ),
            ...potentialAdmins
                .map(
                  (potentialAdmin) =>
                      SelectAdminTile(viewModel: potentialAdmin),
                )
                .toList(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: viewModel.onCancel,
          child: Text(
            localization.commonCancel,
          ),
        ),
        TextButton(
          onPressed: viewModel.onLeaveHome?.command,
          child: Text(
            localization.homeProfileLeaveDialogLeave,
          ),
        )
      ],
    );
  }
}
