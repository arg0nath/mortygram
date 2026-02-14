import 'package:drift/drift.dart';

class PaginationMetadataTable extends Table {
  // Composite key: endpoint + page
  TextColumn get endpoint => text()();
  IntColumn get page => integer()();

  IntColumn get count => integer()();
  IntColumn get pages => integer()();
  TextColumn get next => text().nullable()();
  TextColumn get prev => text().nullable()();

  // Timestamp to track when this page was last synced
  DateTimeColumn get lastSynced => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {endpoint, page};
}
