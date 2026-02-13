import 'package:drift/drift.dart';
import 'package:mortygram/core/database/app_database.dart';
import 'package:mortygram/features/characters/data/dtos/character_dto.dart';
import 'package:mortygram/features/characters/data/mapper/character_dto_x.dart';
import 'package:mortygram/features/pagination/domain/entities/pagination_meta.dart';

abstract interface class CharactersLocalDataSource {
  Future<List<CharacterDto>> getCharacters(int page);
  Future<void> cacheCharacters(List<CharacterDto> characters);
  Future<void> cachePaginationMeta(String endpoint, int page, PaginationMeta meta);
  Future<PaginationMeta?> getPaginationMeta(String endpoint, int page);
}

class CharactersLocalDataSourceImpl implements CharactersLocalDataSource {
  const CharactersLocalDataSourceImpl(this._db);

  final AppDatabase _db;

  @override
  Future<List<CharacterDto>> getCharacters(int page) async {
    final List<CharactersTableData> rows = await _db.getCharactersByPage(page);
    return rows.map((CharactersTableData e) => e.toDto()).toList();
  }

  @override
  Future<void> cacheCharacters(List<CharacterDto> characters) async {
    final List<CharactersTableCompanion> companions = characters.map((CharacterDto e) => e.toCompanion()).toList();
    await _db.insertCharacters(companions);
  }

  @override
  Future<void> cachePaginationMeta(String endpoint, int page, PaginationMeta meta) async {
    final companion = PaginationMetadataTableCompanion(
      endpoint: Value(endpoint),
      page: Value(page),
      count: Value(meta.count),
      pages: Value(meta.pages),
      next: Value(meta.next),
      prev: Value(meta.prev),
    );
    await _db.insertPaginationMetadata(companion);
  }

  @override
  Future<PaginationMeta?> getPaginationMeta(String endpoint, int page) async {
    final PaginationMetadataTableData? data = await _db.getPaginationMetadata(endpoint, page);
    if (data == null) return null;
    
    return PaginationMeta(
      count: data.count,
      pages: data.pages,
      next: data.next,
      prev: data.prev,
    );
  }
}
