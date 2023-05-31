import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/common/avatar_picker/avatar_picker.dart';
import 'package:nestify/ui/common/text_field/nestify_text_field.dart';
import 'package:nestify/ui/join_home/components/join_home_user_color_selector.dart';
import 'package:nestify/ui/join_home/join_home_view_model.dart';

class CreateProfileView extends StatelessWidget {
  final JoinHomeUserProfileViewModel viewModel;

  const CreateProfileView({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: AvatarPicker(
                    viewModel: viewModel.userAvatarViewModel,
                    backgroundIcon: Icons.person_outline_outlined,
                  ),
                ),
                const SizedBox(height: 32),
                NestifyTextField(
                  viewModel: viewModel.userNameViewModel,
                  label: localization.createUserProfileNameHint,
                ),
                const SizedBox(height: 32),
                NestifyMultilineTextField(
                  viewModel: viewModel.userBioViewModel,
                  label: localization.createUserProfileBioHint,
                  height: 120,
                ),
                const SizedBox(height: 32),
                JoinHomeUserColorSelector(colors: viewModel.availableColors),
                const SizedBox(height: 32),
                const Spacer(),
                OutlinedButton(
                  onPressed: viewModel.onJoin?.command,
                  child: viewModel.isLoading
                      ? const Center(
                          child: SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      : Text(localization.joinHomeJoin),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
