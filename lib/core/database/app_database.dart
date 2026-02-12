import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'tables/characters_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: <Type>[CharactersTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  // WATCH (reactive)
  Stream<List<CharactersTableData>> watchCharacters() {
    return select(charactersTable).watch();
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

  // CLEAR
  Future<void> clearCharacters() => delete(charactersTable).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final File file = File(path.join(dir.path, 'mortygram.sqlite'));
    return NativeDatabase(file);
  });
}
