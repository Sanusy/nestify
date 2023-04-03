import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/common/avatar_picker/avatar_picker.dart';
import 'package:nestify/ui/common/text_field/nestify_text_field.dart';
import 'package:nestify/ui/create_home/create_home_view_model.dart';
import 'package:nestify/ui/create_home/user_profile_step/create_home_color_selector/create_home_color_selector_view.dart';

class CreateUserProfileStepView extends StatelessWidget {
  final CreateUserProfileStepViewModel viewModel;

  const CreateUserProfileStepView({
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
                  label: localization.createHomeUserProfileNameHint,
                ),
                const SizedBox(height: 32),
                NestifyMultilineTextField(
                  viewModel: viewModel.userBioViewModel,
                  label: localization.createHomeUserProfileBioHint,
                  height: 120,
                ),
                const SizedBox(height: 32),
                CreateHomeColorSelectorView(
                  viewModel: viewModel.colorSelectorViewModel,
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: viewModel.onBack?.command,
                        child: Text(localization.commonBack),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: viewModel.onCreate?.command,
                        child: viewModel.isLoading
                            ? const Center(
                                child: SizedBox(
                                  height: 24,
                                  width: 24,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                ),
                              )
                            : Text(localization.createHomeCreate),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
