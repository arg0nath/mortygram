import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mortygram/config/theme/presentation/bloc/theme_bloc.dart';
import 'package:mortygram/core/common/constants/app_const.dart';

class ThemeToggleTile extends StatelessWidget {
  const ThemeToggleTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.palette_outlined),
      title: Text('settings.appearance'.tr()),
      trailing: BlocBuilder<ThemeCubit, String>(
        builder: (BuildContext context, String themeMode) {
          final bool isDarkMode = themeMode == AppConst.darkThemeKey;
          return Switch.adaptive(
            value: isDarkMode,
            onChanged: (bool value) => context.read<ThemeCubit>().setTheme(value ? AppConst.darkThemeKey : AppConst.lightThemeKey),
            thumbIcon: WidgetStatePropertyAll(Icon(isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded)),
          );
        },
      ),
    );
  }
}
