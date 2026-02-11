import 'package:flutter/material.dart';

class AppConst {
  AppConst._(); // Prevent instantiation
  // #region // * Debug Stuff
  static const bool showLog = true;

  static const String logResetColor = '\u001b[0m';
  static const String logErrorColor = '\u001b[31m';
  static const String logWarningColor = '\u001b[32m';
  static const String logWtfColor = '\u001b[36;1m';
  // #endregion

  static const String kFirstTimerKey = 'first_timer';
  static const String kIsFirstTimeUser = 'is_first_time_user';

  static const String appName = 'Mortygram';

  static const String baseApiUrl = 'rickandmortyapi.com/api';
  static const String charactersApiUrl = '/character';
  static const String characterDetailsApiUrl = '/character/{characterId}';
  static const String characterEpisodesApiUrl = '/location';
  static const String characterLocationsApiUrl = '/episode';

  static const int retryMaxAttempts = 2;
  static const int apiStatusOk = 200;

  static const int emptyInt = 0;
  static const double emptyDouble = 0.0;
  static const String emptyGuid = '00000000-0000-0000-0000-000000000000';
  static const String emptyString = '';

  //appbar delegate stuff
  static const double typeDetailsAppBarDelegateMaxExtend = 330;
  static const double typeDetailsAppBarDelegateMinExtend = 180;

  //* SCROLLBAR CONSTANTS
  static const Radius scrollbarRadius = Radius.circular(10);
  static const double scrollbarThickness = 3.0;
  static const Color scrollbarColor = Color(0xFFC5C5C5);

  //customNetworkImage customization
  static const double networkImageBorderRadius = 80.0;
  static const double networkImageNoBorderRadius = 0.0;
  static const double networkImagePlaceholderWidth = 1.0;

  static const double dialogPadding = 16;
  static BorderRadius mainRadius = BorderRadius.circular(28);

  static const double dialogBorderWidth = 1;

  //dot scoll

  static const int userFavoritesPopMenuClearAllValue = 0;

  static const double expandedBarHeight = 200;
  static const double collapsedBarHeight = 130;

  // #region // * App Preferences
  static const String prefsSelectedTypeName = 'selected_type_name';
  static const String prefsSelectedLocale = 'selected_locale';
  static const String prefsInitBoot = 'init_boot';
  static const String prefsIsDarkMode = 'is_dark_mode';
  // #endregion
}
