import 'package:equatable/equatable.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/config/usecase/usecase.dart';
import 'package:mortygram/features/translations/domain/repos/translations_repo.dart';

class CacheSelectedLanguage implements UseCaseWithParams<void, CacheSelectedLangParams> {
  const CacheSelectedLanguage(this._repository);

  final TranslationsRepo _repository;

  @override
  ResultFutureVoid call(CacheSelectedLangParams params) async => _repository.cacheSelectedLanguage(params.code);
}

class CacheSelectedLangParams extends Equatable {
  const CacheSelectedLangParams(this.code);

  final String code;

  @override
  List<Object?> get props => <Object?>[code];
}
