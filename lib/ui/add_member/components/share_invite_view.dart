import 'package:flutter/material.dart';
import 'package:nestify/gen/assets.gen.dart';
import 'package:nestify/ui/add_member/add_member_view_model.dart';
import 'package:nestify/ui/common/network_circle_avatar.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// This view should not be used to build UI.
/// It is used to make picture if home invite with screenshot package.
class ShareInviteView extends StatelessWidget {
  final String inviteDescription;
  final HomeInviteViewModel viewModel;

  const ShareInviteView({
    Key? key,
    required this.inviteDescription,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  NetworkCircleAvatar(
                    radius: 32,
                    placeholder: Icon(
                      Icons.home_outlined,
                      size: 24,
                      color: theme.colorScheme.primary,
                    ),
                    avatarUrl: viewModel.humeAvatarUrl,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          viewModel.homeName,
                          style: theme.textTheme.bodyLarge,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                        ),
                        if (viewModel.homeAddress != null)
                          Text(
                            viewModel.homeAddress!,
                            style: theme.textTheme.bodyMedium,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                inviteDescription,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              QrImageView(
                data: viewModel.inviteUrl,
                size: 226,
                // TODO: Replace with app icon
                embeddedImage: Assets.images.qrCodePicture.provider(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
