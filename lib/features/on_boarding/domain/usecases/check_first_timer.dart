import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/config/usecase/usecase.dart';
import 'package:mortygram/features/on_boarding/domain/repos/on_boarding_repo.dart';

class CheckFirstTimer implements UseCaseWithoutParams<bool> {
  const CheckFirstTimer(this._repository);

  final OnBoardingRepository _repository;

  @override
  ResultFuture<bool> call() async => _repository.checkFirstTimer();
}
