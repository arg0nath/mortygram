import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/config/usecase/usecase.dart';
import 'package:mortygram/features/on_boarding/domain/repos/on_boarding_repo.dart';

class CacheFirstTimer implements UseCaseWithoutParams<void> {
  const CacheFirstTimer(this._repository);

  final OnBoardingRepository _repository;

  @override
  ResultFutureVoid call() async => _repository.cacheFirstTimer();
}
