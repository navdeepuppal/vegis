import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseConnect {
  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'tutorialdb_2.db';

    var notesDatabase =
        await openDatabase(path, version: 2, onCreate: createTable);
    return notesDatabase;
  }

  void createTable(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE fruits(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, address TEXT)');
  }

  Future<int> insertStatic() async {
    Database db = await this.database;
    var result = await db.rawInsert(
        "INSERT INTO fruits(name,address) VALUES('peter parker','queens')");
    return result;
  }

  Future<List<Map<String, dynamic>>> getList() async {
    Database db = await this.database;
    var result = await db.rawQuery('SELECT * FROM fruits order by id ASC');
    return result;
  }

  Future<int> insertUpdateDynamic(int id, String name, String address) async {
    Database db = await this.database;

    var result = 0;

    if (id == 0) {
      result = await db.rawInsert("INSERT INTO fruits(name,address) VALUES('" +
          name +
          "','" +
          address +
          "')");
    } else {
      await db.rawUpdate("UPDATE fruits set name='" +
          name +
          "', address='" +
          address +
          "' where id='" +
          id.toString() +
          "'");

      result = id;
    }

    return result;
  }

  Future<List<Map<String, dynamic>>> getSpecificEmployee(int id) async {
    Database db = await this.database;

    var result = await db.rawQuery(
        'SELECT * FROM fruits where id=' + id.toString() + ' order by id ASC');

    return result;
  }

  Future<int> deleteEntry(int id) async {
    Database db = await this.database;
    await db.execute("DELETE from fruits where id='" + id.toString() + "'");
    return id;
  }
}
