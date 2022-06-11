import 'package:inventor_assistant/model/Goods.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = 'goods';

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'goods.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          return db.execute(
            '''CREATE TABLE $_tableName
            (id INTEGER PRIMARY KEY AUTOINCREMENT,
            goodsGroup STRING,
            goodsName STRING,
            imageUrl STRING,
            startDate STRING,
            endDate STRING,
            annotation STRING)''',
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Goods goods) async {
    print("insert function called");
    if (_db == null) return 0;
    return await _db!.insert(_tableName, goods.toJson());
  }

  static Future<int> delete(int id) async {
    if (_db == null) return 0;
    return await _db!.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("query function called");
    if (_db == null) return [];
    return _db!.query(_tableName);
  }

  static Future<int> update(int id) async {
    print("update function called");
    if (_db == null) return 0;
    return await _db!.rawUpdate('''
    UPDATE $_tableName   
    SET isCompleted = ?
    WHERE id = ?
    ''', [1, id]);
  }
}
