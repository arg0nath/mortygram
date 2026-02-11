import 'package:flutter/material.dart';

abstract class AppPalette {
  AppPalette._();

  static const Color transparent = Colors.transparent;

  static const Color white = Color(0xFFE6E6E6);
  static const Color black = Color(0xff313132);
  static const Color grey = Color(0xFF979797);

  static const Color shadowLight = Color(0xFFB4B4B4);
  static const Color shadowDark = Color(0xFF404040);

  static const Color orange = Colors.orange;
  static const Color blue = Colors.blueAccent;
  static const Color blueGrey = Colors.blueGrey;

  static const List<Color> purpleGradient = <Color>[Color(0xFF6B46C1), Color(0xFF9333EA)];
  static const List<Color> blueGradient = <Color>[blue, Color(0xFF06B6D4)];
  static const List<Color> orangeGradient = <Color>[Color(0xFFEA580C), Color(0xFFF59E0B)];
  static const List<Color> greenGradient = <Color>[Color(0xFF059669), Color(0xFF10B981)];
}
