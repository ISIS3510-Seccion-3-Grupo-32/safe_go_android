import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:safe_go_dart/Model/TravelData.dart';
import 'package:sqflite/sqflite.dart';

class LocalSQLDB {
  Database? _database;

  LocalSQLDB();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await init();
    return _database!;
  }

  Future<Database> init() async {
    String path = await getDatabasesPath();
    WidgetsFlutterBinding.ensureInitialized();
    var database = openDatabase(
        join(path, 'travel_data.db')
        , version: 1, onCreate: (db, version) {
      db.execute(
          'CREATE TABLE IF NOT EXISTS travel_data (id INTEGER PRIMARY KEY, '
              'source TEXT, '
              'destination TEXT,'
              'date TEXT)');
    });
    return database;
  }


  Future<void> insertTravelData(TravelData travelData) async {
    final db = await database;
    await db.insert(
      'travel_data',
      travelData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, Object?>>> selectTravelData(id) async {
    final db = await database;
    List<Map<String, Object?>> query = await db.rawQuery(
        "SELECT * FROM travel_data WHERE id = $id");
    print(query);
    print(query);
    print(query);print(query);print(query);print(query);
    print(query);
    print(query);print(query);print(query);print(query);print(query);print(query);print(query);print(query);




    return query;
  }
}