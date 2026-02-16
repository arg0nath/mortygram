import 'package:flutter/material.dart';

class FilterRow extends StatelessWidget {
  const FilterRow({
    required this.label,
    required this.hintText,
    required this.initialSelection,
    required this.dropdownMenuEntries,
    required this.keyPrefix,
    required this.onSelected,
  });

  final String label;
  final String hintText;
  final String? initialSelection;
  final List<DropdownMenuEntry<String>> dropdownMenuEntries;
  final String keyPrefix;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(label),
        DropdownMenu<String>(
          key: ValueKey('${keyPrefix}_$initialSelection'),
          hintText: hintText,
          initialSelection: initialSelection,
          dropdownMenuEntries: dropdownMenuEntries,
          onSelected: onSelected,
        ),
      ],
    );
  }
}
