import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mortygram/config/theme/app_theme.dart';
import 'package:mortygram/config/theme/domain/entity/theme_entity.dart';
import 'package:mortygram/config/theme/presentation/bloc/theme_bloc.dart';
import 'package:mortygram/core/routes/go_router.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (BuildContext context, ThemeState themeState) {
        if (themeState.themeEntity == null) {
          return const SizedBox(); // or a loading indicator
        }

        final bool isDark = themeState.themeEntity!.themeType == ThemeType.dark;
        return _AppMaterialApp(isDark: isDark);
      },
    );
  }
}

class _AppMaterialApp extends StatelessWidget {
  const _AppMaterialApp({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      // theme: AppTheme.light(),
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      routerConfig: router,
    );
  }
}
