import 'package:sqflite/sqflite.dart';
import 'package:sqlitedemo/Database/database_helper.dart';
import 'package:sqlitedemo/Models/taskModel.dart';

class TaskDB {
  final tablename = 'task';
  Future<void> createTable(Database database) async {
    final query =
        ''' CREATE TABLE IF NOT EXISTS $tablename('id' INTEGER PRIMARY KEY AUTOINCREMENT,'title' TEXT NOT NULL, 'created_at' INTEGER NOT NULL DEFAULT(strftime('%s','now')),'updated_at' INTEGER)''';
    return await database.execute(query);
  }

  Future<int> insertData({required String title}) async {
    final database = await DBHelper().database;
    final query = '''INSERT INTO $tablename(title,created_at) VALUES(?,?)''';
    var result = await database
        .rawInsert(query, [title, DateTime.now().millisecondsSinceEpoch]);
    return result;
  }

  Future<List<TaskModel>> fetchAllData() async {
    final database = await DBHelper().database;
    final query =
        '''SELECT * FROM $tablename ORDER BY COALESCE (updated_at,created_at) ''';
    var result = await database.rawQuery(query);
    var datalist = result.map((e) => TaskModel.fromSqliteDatabase(e)).toList();
    return datalist;
  }

  Future<TaskModel> fetchById({required int id}) async {
    final database = await DBHelper().database;
    final query = '''SELECT * FROM $tablename WHERE id=$id''';
    var result = await database.rawQuery(query);
    return TaskModel.fromSqliteDatabase(result.first);
  }

  Future<void> deleteData({required int id}) async {
    final database = await DBHelper().database;
    final query = '''DELETE FROM $tablename WHERE id=$id''';
    await database.rawDelete(query);
  }

  Future<int> updateData({required int id, required String title}) async {
    final database = await DBHelper().database;
    final result = await database.update(tablename,
        {'title': title, 'created_at': DateTime.now().millisecondsSinceEpoch},
        where: 'id=?',
        whereArgs: [id],
        conflictAlgorithm: ConflictAlgorithm.rollback);
    return result;
  }
}
