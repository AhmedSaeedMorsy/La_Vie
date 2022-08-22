import 'package:la_vie/domain/sqlite_model.dart';
import 'package:sqflite/sqflite.dart';

class SqlHelper {
  late SqliteModel sqlColumn;
  late int id;
  late String name;
  late String imageUrl;
  late String price;
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      SqliteModel.name: name,
      SqliteModel.id: id,
      SqliteModel.price: price,
      SqliteModel.imageUrl: imageUrl,
    };

    return map;
  }

  SqlHelper();

  SqlHelper.fromMap(Map<String, dynamic> map) {
    id = map[SqliteModel.id];
    name = map[SqliteModel.name];
    price = map[SqliteModel.price];
    imageUrl = map[SqliteModel.imageUrl];
  }
}

class SqliteProvider {
  late Database db;

  Future open() async {
    db = await openDatabase("data/local/myCart.db", version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table myCart ( 
  id integer primary key autoincrement, 
  name text ,price text,imageUrl text)
''');
    });
  }

  Future<SqlHelper> insert(SqlHelper cart) async {
    cart.id = await db.insert("myCart", cart.toMap());
    return cart;
  }

  Future<SqlHelper?> getCart(int id) async {
    List<Map<String, dynamic>> maps = await db.query("myCart",
        columns: [
          SqliteModel.id,
          SqliteModel.name,
          SqliteModel.price,
          SqliteModel.imageUrl,
        ],
        where: '${SqliteModel.id} = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return SqlHelper.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db
        .delete("myCart", where: '${SqliteModel.id} = ?', whereArgs: [id]);
  }

  Future<int> update(SqlHelper cart) async {
    return await db.update("myCart", cart.toMap(),
        where: '${SqliteModel.id} = ?', whereArgs: [cart.id]);
  }

  Future close() async => db.close();
}
