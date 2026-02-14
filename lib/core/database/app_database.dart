import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:mortygram/core/database/tables/character_details_table.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'tables/characters_table.dart';
import 'tables/pagination_metadata_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: <Type>[CharactersTable, CharacterDetailsTable, PaginationMetadataTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 6;

  // GET characters by page (Future)
  Future<List<CharactersTableData>> getCharactersByPage(int page) {
    return (select(charactersTable)
          ..where((tbl) => tbl.page.equals(page))
          ..orderBy([(t) => OrderingTerm.asc(t.id)]))
        .get();
  }

  // INSERT OR UPDATE
  Future<void> insertCharacters(
    List<CharactersTableCompanion> characters,
  ) async {
    await batch((Batch batch) {
      batch.insertAllOnConflictUpdate(
        charactersTable,
        characters,
      );
    });
  }

  // INSERT OR UPDATE pagination metadata
  Future<void> insertPaginationMetadata(PaginationMetadataTableCompanion metadata) async {
    await into(paginationMetadataTable).insertOnConflictUpdate(metadata);
  }

  // Get pagination metadata
  Future<PaginationMetadataTableData?> getPaginationMetadata(String endpoint, int page) {
    return (select(paginationMetadataTable)..where((tbl) => tbl.endpoint.equals(endpoint) & tbl.page.equals(page))).getSingleOrNull();
  }

  // GET character details by ID
  Future<CharacterDetailsTableData?> getCharacterDetailsById(int characterId) {
    return (select(characterDetailsTable)..where((tbl) => tbl.id.equals(characterId))).getSingleOrNull();
  }

  // INSERT OR UPDATE character details
  Future<void> insertCharacterDetails(
    CharacterDetailsTableCompanion characterDetails,
  ) async {
    await into(characterDetailsTable).insertOnConflictUpdate(characterDetails);
  }

  // CLEAR
  Future<void> clearCharacters() => delete(charactersTable).go();
  Future<void> clearCharacterDetails() => delete(characterDetailsTable).go();
  Future<void> clearPaginationMetadata() => delete(paginationMetadataTable).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final File file = File(path.join(dir.path, 'mortygram.sqlite'));
    return NativeDatabase(file);
  });
}
