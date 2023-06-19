import 'package:flutter/material.dart';
import 'package:nestify/ui/common/network_circle_avatar.dart';
import 'package:nestify/ui/home_profile/components/leave_home_dialog/leave_home_dialog_view_model.dart';

class SelectAdminTile extends StatelessWidget {
  final SelectAdminViewModel viewModel;

  const SelectAdminTile({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      onTap: viewModel.onSelectAdmin?.command,
      leading: NetworkCircleAvatar(
        radius: 20,
        avatarUrl: viewModel.userPictureUrl,
        placeholder: Text(
          viewModel.userName.characters.first.toUpperCase(),
          style:
              theme.textTheme.titleMedium?.copyWith(color: theme.primaryColor),
        ),
      ),
      title: Text(viewModel.userName),
      trailing: Radio<SelectAdminViewModel>(
        onChanged: (_) => viewModel.onSelectAdmin?.command(),
        value: viewModel,
        groupValue: viewModel.onSelectAdmin == null ? viewModel : null,
      ),
    );
  }
}
