part of 'translations_cubit.dart';

sealed class TranslationsState extends Equatable {
  const TranslationsState();

  @override
  List<Object> get props => <Object>[];
}

final class TranslationsInitial extends TranslationsState {
  const TranslationsInitial();
}

class CachingSelectedLanguage extends TranslationsState {
  const CachingSelectedLanguage();
}

class SelectedLanguageCached extends TranslationsState {
  const SelectedLanguageCached();
}

class SelectedLanguageLoaded extends TranslationsState {
  const SelectedLanguageLoaded(this.languageCode);

  final String languageCode;

  @override
  List<Object> get props => <Object>[languageCode];
}

class TranslationsError extends TranslationsState {
  const TranslationsError(this.message);

  final String message;

  @override
  List<Object> get props => <Object>[message];
}
