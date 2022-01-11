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
    String path = directory.path + 'tutorialdb_1.db';

    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: createTable);
    return notesDatabase;
  }

  void createTable(Database db, int newVersion) async {
    await db.execute(
        //'CREATE TABLE vegetables(string id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, address TEXT)');
        'CREATE TABLE vegetables(string img, string name, string note, INTEGER price, string units, INTEGER quantity, INTEGER totalPrice)');
  }

  Future<int> insertStatic() async {
    Database db = await this.database;
    var result = await db.rawInsert(
        "INSERT INTO vegetables(name,address) VALUES ('peter parker','queens')");
    return result;
  }

  Future<List<Map<String, dynamic>>> getList() async {
    Database db = await this.database;
    var result = await db.rawQuery('SELECT * FROM vegetables order by id ASC');
    return result;
  }

  Future<int> insertUpdateDynamic(String img, String name, String note,
      int price, String units, int quantity, int totalPrice) async {
    Database db = await this.database;

    var result = 0;

    if (price == 0) {
      result = await db.rawInsert(
          "INSERT INTO vegetables(name,address) VALUES('" +
              name +
              "','" +
              note +
              "')");
    } else {
      await db.rawUpdate("UPDATE vegetables set name='" +
          name +
          "', address='" +
          note +
          "' where id='" +
          price.toString() +
          "'");

      result = price;
    }

    return result;
  }

  Future<List<Map<String, dynamic>>> getSpecificvegetables(int price) async {
    Database db = await this.database;

    var result = await db.rawQuery('SELECT * FROM vegetables where id=' +
        price.toString() +
        ' order by id ASC');

    return result;
  }

  Future<int> deleteEntry(int price) async {
    Database db = await this.database;
    await db
        .execute("DELETE from vegetables where id='" + price.toString() + "'");
    return price;
  }
}
