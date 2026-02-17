import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mortygram/config/theme/domain/entity/theme_entity.dart';
import 'package:mortygram/config/theme/presentation/bloc/theme_bloc.dart';

class ThemeToggleTile extends StatelessWidget {
  const ThemeToggleTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.palette_outlined),
      title: Text('settings.appearance'.tr()),
      trailing: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (BuildContext context, ThemeState state) {
          final bool isDarkMode = state.themeEntity?.themeType == ThemeType.dark;
          return Switch.adaptive(
            value: isDarkMode,
            onChanged: (bool value) => context.read<ThemeBloc>().add(ToggleThemeEvent(value)),
            thumbIcon: WidgetStatePropertyAll(Icon(isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded)),
          );
        },
      ),
    );
  }
}
