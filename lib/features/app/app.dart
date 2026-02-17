import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mortygram/config/theme/app_theme.dart';
import 'package:mortygram/config/theme/domain/entity/theme_entity.dart';
import 'package:mortygram/config/theme/presentation/bloc/theme_bloc.dart';
import 'package:mortygram/core/routes/go_router.dart';
import 'package:mortygram/core/services/di_imports.dart';
import 'package:mortygram/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:nested/nested.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider<ThemeBloc>(create: (BuildContext context) => sl<ThemeBloc>()),
        BlocProvider<CharactersBloc>(create: (BuildContext context) => sl<CharactersBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (BuildContext context, ThemeState state) {
          // Show loading screen while theme is being loaded
          if (state.status == ThemeStatus.initial || state.status == ThemeStatus.loading) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              home: const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }

          // Determine the current theme based on the bloc's state
          final bool isDark = state.themeEntity?.themeType == ThemeType.dark;

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
