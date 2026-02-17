import 'package:flutter/material.dart';

abstract class AppPalette {
  AppPalette._();

  static const Color transparent = Colors.transparent;
  static const Color green = Colors.greenAccent;
  static const Color red = Colors.redAccent;
  static const Color grey = Colors.grey;
  static const List<Color> purpleGradient = <Color>[Color(0xFF6B46C1), Color(0xFF9333EA)];
  static const List<Color> blueGradient = <Color>[Color(0xff1DA4C4), Color(0xff1DA4C4)];
  static const List<Color> orangeGradient = <Color>[Color(0xFFEA580C), Color(0xFFF59E0B)];
  static const List<Color> greenGradient = <Color>[Color(0xFF97c769), Color(0xFF63De38)];
}
