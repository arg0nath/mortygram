import 'package:flutter/material.dart';
import 'package:mortygram/config/theme/presentation/app_palette.dart';

/// Character status enum
enum CharacterStatus {
  alive,
  dead,
  unknown
  ;

  /// parse status from string
  static CharacterStatus fromString(String status) => switch (status.toLowerCase()) {
    'alive' => CharacterStatus.alive,
    'dead' => CharacterStatus.dead,
    _ => CharacterStatus.unknown,
  };

  /// gett color for the status
  Color get color => switch (this) {
    CharacterStatus.alive => AppPalette.green,
    CharacterStatus.dead => AppPalette.red,
    CharacterStatus.unknown => AppPalette.grey,
  };
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
