import 'package:flutter/material.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
import 'package:mortygram/core/common/widgets/status_indicator.dart';

/// A widget that displays a character information item with a label and value
class CharacterInfoItem extends StatelessWidget {
  const CharacterInfoItem({
    required this.label,
    required this.value,
    this.showStatusIndicator = false,
    super.key,
  });

  final String label;
  final String value;
  final bool showStatusIndicator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 16, vertical: 8),
      child: Row(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: context.textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              spacing: 8,
              children: [
                if (showStatusIndicator) StatusIndicator.fromString(value),
                Expanded(
                  child: Text(
                    value,
                    style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
