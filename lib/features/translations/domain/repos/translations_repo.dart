import 'package:mortygram/config/typedefs/typedefs.dart';

abstract interface class TranslationsRepo {
  const TranslationsRepo();

  ResultFutureVoid cacheSelectedLanguage(String code);
  ResultFuture<String> getCachedSelectedLanguage();
}
