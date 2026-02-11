abstract class RoutePath {
  static const String rootPage = '/';
  static const String onBoardingPage = '/${RouteName.onBoardingPageName}';
  static const String charactersPage = '/${RouteName.charactersPageName}';
  static const String characterDetailsPage = '/${RouteName.characterDetailsPageName}';
  static const String settingsPage = '/${RouteName.settingsPageName}';
}

abstract class RouteName {
  static const String onBoardingPageName = 'on-boarding';
  static const String charactersPageName = 'characters';
  static const String characterDetailsPageName = 'character-details';
  static const String settingsPageName = 'settings';
}
