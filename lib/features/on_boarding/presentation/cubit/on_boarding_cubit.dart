import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/core/common/constants/app_const.dart';

/// OnBoardingCubit manages whether user has completed onboarding
/// State: bool (true = first timer, false = completed onboarding)
class OnBoardingCubit extends HydratedCubit<bool> {
  OnBoardingCubit() : super(true); // Default: user is first timer

  /// Mark onboarding as completed
  void completeOnboarding() => emit(false);

  /// Check if user is first timer
  bool get isFirstTimer => state;

  @override
  bool fromJson(DataMap json) => json[AppConst.isFirstTimerKey] as bool? ?? true;

  @override
  DataMap toJson(bool state) => {AppConst.isFirstTimerKey: state};
}
