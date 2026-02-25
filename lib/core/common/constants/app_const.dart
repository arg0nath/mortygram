import 'package:flutter/material.dart';

class AppConst {
  AppConst._(); // Prevent instantiation
  // #region // * Shared Preferences Keys
  static const String kFirstTimerKey = 'first_timer';
  static const String kIsFirstTimeUser = 'is_first_time_user';
  static const String kSelectedLanguageKey = 'selected_language';
  // #endregion

  static const String appName = 'Mortygram';

  static const String charactersApiUrl = '/character';
  static const String characterDetailsApiUrl = '/character';
  static const String characterLocationApiUrl = '/location';
  static const String characterEpisodeApiUrl = '/episode';

  static const String darkThemeKey = 'dark';
  static const String lightThemeKey = 'light';

  static const int retryMaxAttempts = 2;

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en', 'US'),
    Locale('el', 'GR'),
  ];

  static const Map<String, String> languageNames = <String, String>{
    'en': 'English',
    'el': 'Ελληνικά',
  };

  static const int emptyInt = 0;
  static const double emptyDouble = 0.0;
  static const String emptyGuid = '00000000-0000-0000-0000-000000000000';
  static const String emptyString = '';

  //appbar delegate stuff
  static const double appBarDelegateMaxExtend = 330;
  static const double appBarDelegateMinExtend = 180;

  //customNetworkImage customization
  static const double networkImageBorderRadius = 80.0;
  static const double networkImageNoBorderRadius = 0.0;
  static const double networkImagePlaceholderWidth = 1.0;

  static const double scrollOffsetThreshold = 200.0;
  static const double loadMoreThreshold = 200.0;

  static const String githubUrl = 'https://github.com/arg0nath';
}
