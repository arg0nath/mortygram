import 'package:mortygram/core/database/app_database.dart';
import 'package:mortygram/features/character_details/data/dtos/character_details_dto.dart';
import 'package:mortygram/features/character_details/data/mapper/character_details_dto_x.dart';

abstract interface class CharacterDetailsLocalDataSource {
  Future<CharacterDetailsDto?> getCharacterDetails(int characterId);
  Future<void> cacheCharacterDetails(CharacterDetailsDto character);
}

class CharacterDetailsLocalDataSourceImpl implements CharacterDetailsLocalDataSource {
  const CharacterDetailsLocalDataSourceImpl(this._db);

  final AppDatabase _db;

  @override
  Future<CharacterDetailsDto?> getCharacterDetails(int characterId) async {
    final CharacterDetailsTableData? row = await _db.getCharacterDetailsById(characterId);
    return row?.toDto();
  }

  @override
  Future<void> cacheCharacterDetails(CharacterDetailsDto character) async {
    final CharacterDetailsTableCompanion companion = character.toCompanion();
    await _db.insertCharacterDetails(companion);
  }
}
