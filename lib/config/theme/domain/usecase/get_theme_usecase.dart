import 'package:mortygram/config/theme/domain/entity/theme_entity.dart';
import 'package:mortygram/config/theme/domain/repository/theme_repo.dart';

class GetThemeUseCase {
  GetThemeUseCase(this._themeRepository);

  final ThemeRepository _themeRepository;

  Future<ThemeEntity> call() async => await _themeRepository.getTheme();
}
