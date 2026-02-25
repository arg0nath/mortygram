import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mortygram/config/theme/presentation/bloc/theme_bloc.dart';
import 'package:mortygram/core/common/constants/app_const.dart';

class ThemeToggleButton extends StatefulWidget {
  const ThemeToggleButton({super.key});

  @override
  State<ThemeToggleButton> createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends State<ThemeToggleButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, String>(
      builder: (BuildContext context, String themeMode) {
        final bool isDarkMode = themeMode == AppConst.darkThemeKey;
        return IconButton(
          onPressed: () {
            context.read<ThemeCubit>().setTheme(isDarkMode ? AppConst.lightThemeKey : AppConst.darkThemeKey);
          },
          icon: Icon(isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded),
        );
      },
    );
  }
}
