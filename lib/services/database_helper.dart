import 'package:earthquake_detection_app/models/riwayat_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Riwayat.db";

  static Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: ((db, version) async => await db.execute(
          "CREATE TABLE Riwayat(id INTEGER PRIMARY KEY, status TEXT NOT NULL, getaran TEXT NOT NULL,hari TEXT NOT NULL, tanggal TEXT NOT NULL, waktu TEXT NOT NULL);")),
      version: _version,
    );
  }

  static Future<int> addRiwayat(Riwayat riwayat) async {
    final db = await _getDB();
    return await db.insert(
      "Riwayat",
      riwayat.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> deleteRiwayat(Riwayat riwayat) async {
    final db = await _getDB();
    return await db.delete(
      "Riwayat",
      where: 'id = ?',
      whereArgs: [riwayat.id],
    );
  }

  static Future<int> deleteAllRiwayat(List<Riwayat>? riwayat) async {
    final db = await _getDB();
    return await db.delete("Riwayat");
  }

  static Future<List<Riwayat>?> getAllRiwayat() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("Riwayat");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
      maps.length,
      (index) => Riwayat.fromJson(
        maps[index],
      ),
    );
  }
}
