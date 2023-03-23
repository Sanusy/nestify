import 'package:flutter/material.dart';
import 'package:nestify/ui/common/avatar_picker/avatar_picker_view_model.dart';

class AvatarPicker extends StatelessWidget {
  final AvatarPickerViewModel viewModel;
  final IconData backgroundIcon;

  const AvatarPicker({
    Key? key,
    required this.viewModel,
    required this.backgroundIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 90,
          foregroundImage:
              viewModel.picture == null ? null : FileImage(viewModel.picture!),
          child: Icon(
            backgroundIcon,
            size: 120,
            color: theme.colorScheme.primary,
          ),
        ),
        Positioned(
          right: 8,
          bottom: 8,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.primary,
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                viewModel.picture == null
                    ? Icons.add_photo_alternate_outlined
                    : Icons.close,
                size: 24,
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
