import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Fruits_DB {
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
        await openDatabase(path, version: 2, onCreate: createTable);
    return notesDatabase;
  }

  void createTable(Database db, int newVersion) async {
    await db.execute(
        //'CREATE TABLE fruits(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, address TEXT)');
        'CREATE TABLE fruits (id TEXT, img TEXT, name TEXT, note TEXT, price INTEGER, units TEXT, quantity INTEGER)');
  }

  Future<int> insertStatic() async {
    Database db = await this.database;
    var result = await db.rawInsert(
        "INSERT INTO fruits(id, img, name, note, price, units, quantity) VALUES ('fru1','https','apple','1kg',90,'kg',7)");
    return result;
  }

  Future<List<Map<String, dynamic>>> getList() async {
    Database db = await this.database;
    var result = await db.rawQuery('SELECT * FROM fruits order by id ASC');
    return result;
  }

  Future<String> insertUpdateDynamic(
    String id,
    String img,
    String name,
    String note,
    int price,
    String units, {
    int quantity = 0,
  }) async {
    Database db = await this.database;

    var result = "";
    //List<Map<String, dynamic>> present = await getSpecificfruits(id);
    //print(present);
    //if (present.length == 0) {
    await db.rawInsert(
        "INSERT INTO fruits(id, img, name, note, price, units, quantity) VALUES('" +
            id +
            "','" +
            img +
            "','" +
            name +
            "','" +
            note +
            "','" +
            price.toString() +
            "','" +
            units +
            "','" +
            quantity.toString() +
            "')");
    /*} else {
      await db.rawUpdate("UPDATE fruits set img='" +
          img +
          "', name='" +
          name +
          "', note='" +
          note +
          "', price='" +
          price.toString() +
          "', units='" +
          units +
          "' where id='" +
          id.toString() +
          "'");

      result = id;
    }*/

    return result;
  }

  Future<List<Map<String, dynamic>>> getSpecificfruits(String id) async {
    Database db = await this.database;

    var result = await db.rawQuery(
        'SELECT * FROM fruits where id=' + id.toString() + ' order by id ASC');

    return result;
  }

  Future<String> deleteEntry(String id) async {
    Database db = await this.database;
    await db.execute("DELETE from fruits where id='" + id.toString() + "'");
    return id;
  }
}
