import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/common/avatar_picker/avatar_picker.dart';
import 'package:nestify/ui/common/text_field/nestify_text_field.dart';
import 'package:nestify/ui/edit_home/edit_home_view_model.dart';

class EditHomeBodyView extends StatelessWidget {
  final EditHomeBodyViewModel viewModel;

  const EditHomeBodyView({
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
              viewModel: viewModel.homeAvatarViewModel,
              backgroundIcon: Icons.home_outlined,
            ),
          ),
          const SizedBox(height: 32),
          NestifyTextField(
            viewModel: viewModel.homeNameViewModel,
            label: localization.editHomeHomeName,
          ),
          const SizedBox(height: 32),
          NestifyTextField(
            viewModel: viewModel.homeAddressViewModel,
            label: localization.editHomeAddress,
          ),
          const SizedBox(height: 32),
          NestifyMultilineTextField(
            viewModel: viewModel.homeAboutViewModel,
            label: localization.editHomeAbout,
            height: 120,
          ),
        ],
      ),
    );
  }
}
