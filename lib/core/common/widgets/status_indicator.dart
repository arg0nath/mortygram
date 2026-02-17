import 'package:flutter/material.dart';

/// Character status enum
enum CharacterStatus {
  alive,
  dead,
  unknown
  ;

  /// Parse status from string
  static CharacterStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return CharacterStatus.alive;
      case 'dead':
        return CharacterStatus.dead;
      default:
        return CharacterStatus.unknown;
    }
  }

  /// Get color for the status
  Color get color {
    switch (this) {
      case CharacterStatus.alive:
        return Colors.green;
      case CharacterStatus.dead:
        return Colors.red;
      case CharacterStatus.unknown:
        return Colors.grey;
    }
  }
}

/// A small circular widget that indicates the status of a character (Alive, Dead, Unknown) using color coding.
class StatusIndicator extends StatelessWidget {
  const StatusIndicator({required this.status, super.key});

  /// constructor that accepts a string and converts it to enum
  factory StatusIndicator.fromString(String status) {
    return StatusIndicator(status: CharacterStatus.fromString(status));
  }

  final CharacterStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: status.color, shape: .circle),
    );
  }
}
