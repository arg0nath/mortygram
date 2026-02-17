import 'package:dartz/dartz.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/core/common/errors/exceptions.dart';
import 'package:mortygram/core/common/errors/failures.dart';
import 'package:mortygram/features/translations/data/datasources/translations_local_data_source.dart';
import 'package:mortygram/features/translations/domain/repos/translations_repo.dart';

class TranslationsRepoImpl implements TranslationsRepo {
  const TranslationsRepoImpl(this._localDataSource);

  final TranslationsLocalDataSource _localDataSource;

  @override
  ResultFutureVoid cacheSelectedLanguage(String code) async {
    try {
      await _localDataSource.cacheSelectedLanguage(code);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<String> getCachedSelectedLanguage() async {
    try {
      final String code = await _localDataSource.getCachedSelectedLanguage();
      return Right(code);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
