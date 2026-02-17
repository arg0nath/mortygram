import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mortygram/config/logger/my_log.dart';
import 'package:mortygram/core/common/errors/failures.dart';
import 'package:mortygram/features/translations/domain/usecases/cache_selected_language.dart';
import 'package:mortygram/features/translations/domain/usecases/get_cached_selected_language.dart';

part 'translations_state.dart';

//after setting test, and creating states, now we set cubit and the usecases we gonna need
class TranslationsCubit extends Cubit<TranslationsState> {
  TranslationsCubit({required CacheSelectedLanguage cacheSelectedLanguage, required GetCachedSelectedLanguage getCachedSelectedLanguage})
    : _getCachedSelectedLanguage = getCachedSelectedLanguage,
      _cacheSelectedLanguage = cacheSelectedLanguage,

      super(const TranslationsInitial());

  final CacheSelectedLanguage _cacheSelectedLanguage;
  final GetCachedSelectedLanguage _getCachedSelectedLanguage;

  Future<void> cacheSelectedLanguage(String code) async {
    emit(const CachingSelectedLanguage());
    final Either<Failure, void> result = await _cacheSelectedLanguage(CacheSelectedLangParams(code));
    myLog('cacheSelectedLanguage result: $result');
    result.fold((Failure failure) => emit(TranslationsError(failure.errorMessage)), (_) => emit(const SelectedLanguageCached()));
  }

  Future<String> getCachedSelectedLanguage() async {
    final Either<Failure, String> result = await _getCachedSelectedLanguage();
    myLog('getCachedSelectedLanguage result: $result');
    return result.fold(
      (Failure failure) {
        emit(TranslationsError(failure.errorMessage));
        return 'en'; // Return default language code on error
      },
      (String code) {
        // emit only  SelectedLanguageLoaded if we have a cached language
        if (code.isNotEmpty) {
          emit(SelectedLanguageLoaded(code));
          myLog('Cached selected language code: $code');
        } else {
          myLog('No cached language found, using default');
        }
        return code.isEmpty ? 'en' : code;
      },
    );
  }
}
