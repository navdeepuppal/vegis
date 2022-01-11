import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ItemInCart {
  String itemId;
  String itemName;
  int price;
  int quantity;

  ItemInCart({this.itemId, this.itemName, this.price, this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'itemName': itemName,
      'price': price,
      'quantity': quantity,
    };
  }

  @override
  String toString() {
    return 'itemInCart{itemId: $itemId, itemName: $itemName, price: $price, quantity: $quantity}';
  }

  Future<void> insertItem(Database database, ItemInCart item) async {
    final db = await database;
    await db.insert(
      'items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ItemInCart>> printItems(Database database) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('items');

    return List.generate(maps.length, (i) {
      return ItemInCart(
        itemId: maps[i]['itemId'],
        itemName: maps[i]['itemName'],
        price: maps[i]['price'],
        quantity: maps[i]['quantity'],
      );
    });
  }

  Future<ItemInCart> findItem(Database database, String id) async {
    final db = database;

    final List<Map<String, dynamic>> maps = await db.query('items');

    List.generate(maps.length, (i) {
      if ('${maps[i]['itemId']}' == '$id')
        return ItemInCart(
          itemId: maps[i]['itemId'],
          itemName: maps[i]['itemName'],
          price: maps[i]['price'],
          quantity: maps[i]['quantity'],
        );
    });

    return null;
  }

  Future<void> updateItem(Database database, ItemInCart item) async {
    final db = database;

    await db.update(
      'items',
      item.toMap(),
      where: 'itemId = ?',
      whereArgs: [item.itemId],
    );
  }

  Future<void> deleteItem(Database database, String id) async {
    final db = database;

    await db.delete(
      'items',
      where: 'itemId = ?',
      whereArgs: [id],
    );
  }

  Future<Database> main() async {
    var database = openDatabase(
      join(await getDatabasesPath(), 'item_database.db'),
      onCreate: (db, version) {
        /*db.execute(
          'DROP TABLE items',
        );
        print("Dropped");

        */
        return db.execute(
          'CREATE TABLE items(itemId TEXT PRIMARY KEY, itemName TEXT, price INTEGER, quantity INTEGER)',
        );
      },
      version: 1,
    );

    return database;

    /*var onion = ItemInCart(
      itemId: 0,
      itemName: 'Onion',
      price: 35,
      quantity: 1,
    );

    await insertItem(database, onion);

    print(await items(database));

    onion = ItemInCart(
      itemId: onion.itemId,
      itemName: onion.itemName,
      price: onion.price + 7,
      quantity: onion.quantity + 1,
    );
    await updateItem(onion);

    print(await items(database));
*/
  }
}
