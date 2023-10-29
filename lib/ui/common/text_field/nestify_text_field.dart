import 'package:flutter/material.dart';
import 'package:nestify/ui/common/text_field/nestify_text_field_view_model.dart';

class NestifyTextField extends StatelessWidget {
  final NestifyTextFieldViewModel viewModel;
  final String label;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;

  const NestifyTextField({
    Key? key,
    required this.viewModel,
    required this.label,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: viewModel.text,
      onChanged: viewModel.onTextChanged?.command,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      enabled: viewModel.onTextChanged != null,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        errorText: viewModel.errorText,
        isDense: true,
      ),
    );
  }
}

class NestifyMultilineTextField extends StatelessWidget {
  final NestifyTextFieldViewModel viewModel;
  final String label;
  final double height;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;

  const NestifyMultilineTextField({
    Key? key,
    required this.viewModel,
    required this.label,
    required this.height,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        initialValue: viewModel.text,
        onChanged: viewModel.onTextChanged?.command,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        enabled: viewModel.onTextChanged != null,
        textInputAction: TextInputAction.newline,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          errorText: viewModel.errorText,
          isDense: true,
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}
