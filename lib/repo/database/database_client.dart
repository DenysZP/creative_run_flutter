import 'dart:async';
import 'dart:io';

import 'package:creative_run/model/category.dart';
import 'package:creative_run/repo/database/category_adapter.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseClient {
  DatabaseClient._();

  static final DatabaseClient db = DatabaseClient._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "AppDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Category ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT"
          ")");
    });
  }

  insert(Category category) async {
    final db = await database;
    var res = await db.insert(
      "Category",
      CategoryAdapter.adaptToJson(category),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return res;
  }

  insertCategories(List<Category> categories) async {
    final db = await database;
    List<dynamic> listRes = new List();
    await db.transaction((txn) async {
      categories.forEach((item) async {
        var res = await db.insert("Category", CategoryAdapter.adaptToJson(item),
            conflictAlgorithm: ConflictAlgorithm.replace);
        listRes.add(res);
      });
    });
    return listRes;
  }

  Future<List<Category>> getAllCategories() async {
    final db = await database;
    var res = await db.query("Category");
    List<Category> list = res.isNotEmpty
        ? res.map((data) => CategoryAdapter.adaptFromJson(data)).toList()
        : [];
    return list;
  }
}
