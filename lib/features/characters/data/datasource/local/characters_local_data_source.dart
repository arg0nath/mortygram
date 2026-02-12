import 'package:mortygram/core/database/app_database.dart';
import 'package:mortygram/features/characters/data/dtos/character_dto.dart';
import 'package:mortygram/features/characters/data/mapper/character_dto_x.dart';

abstract interface class CharactersLocalDataSource {
  Stream<List<CharacterDto>> watchCharacters(int page);
  Future<void> cacheCharacters(List<CharacterDto> characters);
}

class CharactersLocalDataSourceImpl implements CharactersLocalDataSource {
  const CharactersLocalDataSourceImpl(this._db);

  final AppDatabase _db;

  @override
  Stream<List<CharacterDto>> watchCharacters(int page) {
    return _db.watchCharacters().map(
      (List<CharactersTableData> rows) => rows.map((CharactersTableData e) => e.toDto()).toList(),
    );
  }

  @override
  Future<void> cacheCharacters(List<CharacterDto> characters) async {
    final List<CharactersTableCompanion> companions = characters.map((CharacterDto e) => e.toCompanion()).toList();

    await _db.insertCharacters(companions);
  }
}
