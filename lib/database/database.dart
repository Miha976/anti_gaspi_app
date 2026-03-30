import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

// Table produits
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  TextColumn get barcode => text().nullable()();
  DateTimeColumn get expiryDate => dateTime().nullable()();
  DateTimeColumn get addedDate => dateTime()();
  BoolColumn get isConsumed => boolean().withDefault(const Constant(false))();
}

// Table jets
class WasteEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get productName => text()();
  TextColumn get category => text()();
  TextColumn get reason => text()();
  TextColumn get quantity => text().withDefault(const Constant('tout'))();
  DateTimeColumn get date => dateTime()();
}

@DriftDatabase(tables: [Products, WasteEvents])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.addColumn(
              wasteEvents,
              wasteEvents.quantity,
            );
          }
        },
      );


  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'anti_gaspi_db');
  }
}