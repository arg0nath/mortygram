import 'package:mortygram/config/theme/domain/entity/theme_entity.dart';
import 'package:mortygram/config/theme/domain/repository/theme_repo.dart';

class SetThemeUseCase {
  const SetThemeUseCase(this._themeRepository);

  final ThemeRepository _themeRepository;

  Future<void> call(ThemeEntity themeEntity) async => await _themeRepository.setTheme(themeEntity);
}
