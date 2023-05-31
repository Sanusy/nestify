import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/gen/assets.gen.dart';
import 'package:nestify/ui/add_member/add_member_view_model.dart';
import 'package:nestify/ui/add_member/components/share_invite_view.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class AddMemberScreen extends StatelessWidget {
  final AddMemberViewModel viewModel;

  const AddMemberScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.addMemberTitle),
      ),
      body: viewModel.map(
        loading: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
        failed: (failedViewModel) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(localization.commonError),
              TextButton(
                onPressed: failedViewModel.onRetry,
                child: Text(localization.commonRetry),
              ),
            ],
          ),
        ),
        loaded: (loadedViewModel) {
          final qrCodeSize = MediaQuery.sizeOf(context).width - (80 * 2);

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),
                Text(
                  localization.addMemberDisclaimer,
                  style: theme.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64),
                  child: QrImageView(
                    data: loadedViewModel.homeInviteViewModel.inviteUrl,
                    size: qrCodeSize,
                    // TODO: Replace with app icon
                    embeddedImage: Assets.images.qrCodePicture.provider(),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  localization.addMemberDisclaimerSubtitle,
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 64),
                const Spacer(),
                OutlinedButton(
                  onPressed: loadedViewModel.isInviteCapturingInProgress
                      ? null
                      : () {
                          loadedViewModel.onCreatePictureInvite();
                          ScreenshotController()
                              .captureFromWidget(
                                ShareInviteView(
                                  inviteDescription: localization
                                      .addMemberSharedInviteDescription,
                                  viewModel:
                                      loadedViewModel.homeInviteViewModel,
                                ),
                                context: context,
                              )
                              .then(
                                (pictureBytes) =>
                                    loadedViewModel.onShareInvite(pictureBytes),
                              );
                        },
                  child: loadedViewModel.isInviteCapturingInProgress
                      ? const Center(
                          child: SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      : Text(localization.addMemberShareInvite),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
