import 'package:mortygram/core/common/constants/app_const.dart';
import 'package:mortygram/core/common/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TranslationsLocalDataSource {
  const TranslationsLocalDataSource();

  Future<void> cacheSelectedLanguage(String code);
  Future<String> getCachedSelectedLanguage();
}

class TranslationsLocalDataSourceImpl implements TranslationsLocalDataSource {
  TranslationsLocalDataSourceImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<void> cacheSelectedLanguage(String code) async {
    try {
      await _prefs.setString(AppConst.kSelectedLanguageKey, code);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<String> getCachedSelectedLanguage() async {
    try {
      return _prefs.getString(AppConst.kSelectedLanguageKey) ?? AppConst.emptyString;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
