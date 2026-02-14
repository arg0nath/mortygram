import 'package:flutter/material.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';

class CharacterInfoField extends StatelessWidget {
  const CharacterInfoField({required this.title, required this.value, super.key});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.textTheme.labelSmall),
        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
