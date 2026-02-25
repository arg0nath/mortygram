import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mortygram/config/theme/theme.dart';
import 'package:mortygram/core/routes/go_router.dart';
import 'package:mortygram/core/services/di_imports.dart';
import 'package:nested/nested.dart';

import '../translations/translations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider<TranslationsCubit>(create: (BuildContext context) => sl<TranslationsCubit>()..getCachedSelectedLanguage()),
        BlocProvider<ThemeBloc>(create: (BuildContext context) => sl<ThemeBloc>()),
      ],
      child: BlocListener<TranslationsCubit, TranslationsState>(
        listener: (BuildContext context, TranslationsState state) {
          // When cached language is loaded, set it as the active locale
          if (state is SelectedLanguageLoaded) {
            final Locale newLocale = state.languageCode == 'el' ? const Locale('el', 'GR') : const Locale('en', 'US');
            context.setLocale(newLocale);
          }
        },
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (BuildContext context, ThemeState state) {
            // Show loading screen while theme is being loaded
            if (state.status == ThemeStatus.initial || state.status == ThemeStatus.loading) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                home: const Scaffold(body: Center(child: CircularProgressIndicator())),
              );
            }

            // Determine the current theme based on the bloc's state
            final bool isDark = state.themeEntity?.themeType == ThemeType.dark;

            return MaterialApp.router(
              key: ValueKey(context.locale.toString()),
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              darkTheme: AppTheme.dark,
              themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
              routerConfig: router,
            );
          },
        ),
      ),
    );
  }
}
