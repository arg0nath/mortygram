class AppConst {
  AppConst._(); // Prevent instantiation
  // #region // * Shared Preferences Keys
  static const String kFirstTimerKey = 'first_timer';
  static const String kIsFirstTimeUser = 'is_first_time_user';
  // #endregion

  static const String appName = 'Mortygram';

  static const String baseApiUrl = 'rickandmortyapi.com/api';
  static const String charactersApiUrl = 'character';
  static const String characterDetailsApiUrl = 'character';
  static const String characterEpisodesApiUrl = 'location';
  static const String characterLocationsApiUrl = 'episode';

  static const int retryMaxAttempts = 2;

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
}
