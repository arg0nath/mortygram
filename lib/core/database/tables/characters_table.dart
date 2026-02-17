import 'package:drift/drift.dart';

class CharactersTable extends Table {
  IntColumn get id => integer()();
  IntColumn get page => integer()(); // Track which page this character belongs to

  TextColumn get name => text()();
  TextColumn get image => text()();
  TextColumn get status => text()();
  TextColumn get species => text()();
  TextColumn get type => text()();
  TextColumn get gender => text()();

  // Store episodes as JSON string
  TextColumn get episode => text()();
  TextColumn get firstEpisodeName => text().nullable()();
  TextColumn get location => text()();
  TextColumn get origin => text()();

  @override
  Set<Column> get primaryKey => {id};
}
