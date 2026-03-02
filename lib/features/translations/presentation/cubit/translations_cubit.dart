import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mortygram/config/typedefs/typedefs.dart';
import 'package:mortygram/core/common/constants/app_const.dart';

/// TranslationsCubit manages the selected language
/// State: String (language code: 'en', 'el', etc.)
class TranslationsCubit extends HydratedCubit<String> {
  TranslationsCubit() : super('en'); // Default: English

  /// Set selected language
  void setLanguage(String languageCode) => emit(languageCode);

  /// Get current language code
  String get languageCode => state;

  @override
  String fromJson(DataMap json) => json[AppConst.selectedLanguageKey] as String? ?? 'en';

  @override
  DataMap toJson(String state) => {AppConst.selectedLanguageKey: state};
}
