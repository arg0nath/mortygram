import 'package:flutter/material.dart';

/// A small circular widget that indicates the status of a character (Alive, Dead, Unknown) using color coding.
class StatusIndicator extends StatelessWidget {
  const StatusIndicator({required this.status, super.key});

  final String status;

  // TODO(overkill): could use enums
  Color get color {
    switch (status.toLowerCase()) {
      case 'alive':
        return Colors.green;
      case 'dead':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: .circle),
    );
  }
}
