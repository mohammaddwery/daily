import 'package:sqflite/sqflite.dart';
import '../../../core/core_utils.dart';
import 'app_database_scheme.dart';
import 'app_seed_data.dart';
import 'database_manager.dart';

class AppDatabaseManager extends DatabaseManager {
  late Database _db;

  @override
  Future open(String name, int version) async {
    final databasePath = await _createDatabasesPath(name);
    _db = await openDatabase(
      databasePath,
      version: version,
      onCreate: (Database db, int version) async => await _createDatabase(db),
      onUpgrade: (db, oldVersion, newVersion) async => await _createDatabase(db),
    );
  }

  @override
  Future dropDatabase(String name) async {
    final databasePath = await _createDatabasesPath(name);
    await deleteDatabase(databasePath);
  }

  Future<String> _createDatabasesPath(name) async {
    String databasesPath = await getDatabasesPath();
    return '$databasesPath/$name';
  }

  Future _createDatabase(Database db) async {
    /// Create app's database tables
    await db.execute(
        '''create table ${TaskStateScheme.tableName} (
          ${TaskStateScheme.columnId} integer primary key autoincrement, 
           ${TaskStateScheme.columnName} text not null
           )'''
    );
    await db.execute(
        '''create table ${TaskLabelScheme.tableName} (
          ${TaskLabelScheme.columnId} integer primary key autoincrement, 
           ${TaskLabelScheme.columnName} text not null,
           ${TaskLabelScheme.columnColor} text not null
           )'''
    );
    await db.execute(
        '''create table ${TaskScheme.tableName} (
          ${TaskScheme.columnId} integer primary key autoincrement, 
           ${TaskScheme.columnTitle} text not null,
           ${TaskScheme.columnDescription} text not null,
           ${TaskScheme.columnLabelId} int default null,
           ${TaskScheme.columnStateId} int not null,
           ${TaskScheme.columnEndDate} text default null,
           ${TaskScheme.columnCreatedAt} text default current_timestamp,
           foreign key (${TaskScheme.columnLabelId}) references ${TaskLabelScheme.tableName} (${TaskLabelScheme.columnId}) 
           foreign key (${TaskScheme.columnStateId}) references ${TaskScheme.tableName} (${TaskScheme.columnId}) 
           )'''
    );

    /// Insert task's labels transaction
    await db.transaction((txn) async {
      final taskLabels = await CoreUtils.readJsonFile(AppSeedData.taskLabels);
      for (var label in taskLabels) {
        await txn.insert(
          TaskLabelScheme.tableName,
          label,
        );
      }
    });

    /// Insert task's states transaction
    await db.transaction((txn) async {
      final taskStates = await CoreUtils.readJsonFile(AppSeedData.taskStates);
      for (var state in taskStates) {
        await txn.insert(
          TaskStateScheme.tableName,
          state,
        );
      }
    });

    /// Insert tasks transaction
    // await db.transaction((txn) async {
    //   final tasks = await CoreUtils.readJsonFile(AppSeedData.tasks);
    //   for (var task in tasks) {
    //     await txn.insert(
    //       TaskScheme.tableName,
    //       task,
    //     );
    //   }
    // });
  }

  @override
  Future<int> delete(String table, {String? where, List<Object?>? whereArgs
  }) async => await _db.delete(table, where: where, whereArgs: whereArgs);

  @override
  Future<int> insert(String table, Map<String, Object?> values,
      {String? nullColumnHack, ConflictAlgorithm? conflictAlgorithm}) async {
    return await _db.insert(table, values, nullColumnHack: nullColumnHack, conflictAlgorithm: conflictAlgorithm,);
  }

  @override
  Future<List<Map<String, Object?>>> query(String table,
      {bool? distinct,
        List<String>? columns,
        String? where,
        List<Object?>? whereArgs,
        String? groupBy,
        String? having,
        String? orderBy,
        int? limit,
        int? offset}) async {
    return await _db.query(table,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
    );
  }

  @override
  Future<int> rawDelete(String sql, [List<Object?>? arguments]) async {
    return await _db.rawDelete(sql, arguments);
  }

  @override
  Future<int> rawInsert(String sql, [List<Object?>? arguments]) async {
    return await _db.rawInsert(sql, arguments);
  }

  @override
  Future<List<Map<String, Object?>>> rawQuery(String sql, [List<Object?>? arguments]) async {
    return await _db.rawQuery(sql, arguments);
  }

  @override
  Future<int> rawUpdate(String sql, [List<Object?>? arguments]) async {
    return await _db.rawUpdate(sql, arguments);
  }

  @override
  Future<int> update(String table, Map<String, Object?> values,
      {String? where,
    List<Object?>? whereArgs,
    ConflictAlgorithm? conflictAlgorithm,
  }) async {
    return await _db.update(table, values,
      where: where,
      whereArgs: whereArgs,
      conflictAlgorithm: conflictAlgorithm,
    );
  }
}