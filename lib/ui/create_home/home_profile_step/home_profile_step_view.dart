import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nestify/ui/common/avatar_picker/avatar_picker.dart';
import 'package:nestify/ui/common/text_field/nestify_text_field.dart';
import 'package:nestify/ui/create_home/create_home_view_model.dart';

class CreateHomeProfileStepView extends StatelessWidget {
  final CreateHomeProfileStepViewModel viewModel;

  const CreateHomeProfileStepView({
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
                    viewModel: viewModel.homeAvatarViewModel,
                    backgroundIcon: Icons.home_outlined,
                  ),
                ),
                const SizedBox(height: 32),
                NestifyTextField(
                  viewModel: viewModel.homeNameViewModel,
                  label: localization.createHomeName,
                ),
                const SizedBox(height: 32),
                NestifyTextField(
                  viewModel: viewModel.homeAddressViewModel,
                  label: localization.createHomeAddress,
                ),
                const SizedBox(height: 32),
                NestifyMultilineTextField(
                  viewModel: viewModel.homeAboutViewModel,
                  label: localization.createHomeAbout,
                  height: 120,
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed: viewModel.onNext?.command,
                  child: Text(localization.commonNext),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
