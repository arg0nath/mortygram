import 'package:flutter/material.dart';
import 'package:mortygram/config/theme/app_palette.dart';

final ColorScheme lightColorScheme = ColorScheme.fromSeed(
  seedColor: AppPalette.blue,
  primary: AppPalette.blue,
  secondary: AppPalette.orange,
  brightness: Brightness.light,
  surface: _surfaceColorLight,
  onSurface: _onSurfaceLight,
);

final ColorScheme darkColorScheme = ColorScheme.fromSeed(
  seedColor: AppPalette.blueGrey,
  primary: AppPalette.blue,
  secondary: AppPalette.orange,
  brightness: Brightness.dark,
  surface: _surfaceColorDark,
  onSurface: _onSurfaceDark,
);

const Color _surfaceColorLight = Color(0xFFEBEBEB);
const Color _onSurfaceLight = Color(0xFF0D0D0D);

const Color _surfaceColorDark = Color(0xFF0D0D0D);
const Color _onSurfaceDark = Color(0xFFEBEBEB);
