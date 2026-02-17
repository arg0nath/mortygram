import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/config/usecase/usecase.dart';
import 'package:mortygram/features/translations/domain/repos/translations_repo.dart';

class GetCachedSelectedLanguage implements UseCaseWithoutParams<String> {
  const GetCachedSelectedLanguage(this._repo);

  final TranslationsRepo _repo;

  @override
  ResultFuture<String> call() async => _repo.getCachedSelectedLanguage();
}
