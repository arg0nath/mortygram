import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mortygram/config/theme/theme.dart';
import 'package:mortygram/core/common/constants/app_const.dart';
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
        BlocProvider<TranslationsCubit>(create: (BuildContext context) => sl<TranslationsCubit>()),
        BlocProvider<ThemeCubit>(create: (BuildContext context) => sl<ThemeCubit>()),
      ],
      child: BlocListener<TranslationsCubit, String>(
        listener: (BuildContext context, String languageCode) {
          // When language changes, set it as the active locale
          final Locale newLocale = languageCode == 'el' ? const Locale('el', 'GR') : const Locale('en', 'US');
          context.setLocale(newLocale);
        },
        child: BlocBuilder<ThemeCubit, String>(
          builder: (BuildContext context, String themeMode) {
            // Determine the current theme based on the cubit's state
            final bool isDark = themeMode == AppConst.darkThemeKey;

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
