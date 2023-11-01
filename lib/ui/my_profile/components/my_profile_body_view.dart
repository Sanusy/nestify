import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/common/avatar_picker/avatar_picker.dart';
import 'package:nestify/ui/common/text_field/nestify_text_field.dart';
import 'package:nestify/ui/my_profile/my_profile_view_model.dart';

class MyProfileBodyView extends StatelessWidget {
  final MyProfileBodyViewModel viewModel;

  const MyProfileBodyView({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
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
            label: localization.myProfileNameHint,
          ),
          const SizedBox(height: 32),
          NestifyMultilineTextField(
            viewModel: viewModel.userBioViewModel,
            label: localization.myProfileBioHint,
            height: 120,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
