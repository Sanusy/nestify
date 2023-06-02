import 'package:flutter/material.dart';
import 'package:nestify/ui/common/color_selector/color_selector_item_view_model.dart';

class ColorSelectorItem extends StatelessWidget {
  final ColorSelectorItemViewModel viewModel;

  const ColorSelectorItem({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemSize = (MediaQuery.sizeOf(context).width - 32) / 6.1;

    return Container(
      width: itemSize,
      height: itemSize,
      color: viewModel.color,
      child: GestureDetector(
        onTap: viewModel.onSelect?.command,
        child: viewModel.onSelect == null || !viewModel.isEnabled
            ? Icon(
                !viewModel.isEnabled ? Icons.lock_outline : Icons.done,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
