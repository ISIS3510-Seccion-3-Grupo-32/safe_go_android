import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:safe_go_dart/Model/TravelData.dart';
import 'package:sqflite/sqflite.dart';
class LocalDataBase {
  late final database;
  LocalDataBase()
  {
    String path = init();

    WidgetsFlutterBinding.ensureInitialized();
    database = openDatabase(
        join(path, 'travel_data.db')
        , version: 1, onCreate: (db, version) {
      db.execute(
          'CREATE TABLE travel_data (id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'source TEXT, '
              'destination TEXT,'
              'date TEXT)');
    });
  }

  init() async {
    return await getDatabasesPath();
  }

  Future<void> insertTravelData(TravelData travelData) async {
    final db = await database;
    await db.insert(
      'travel_data',
      travelData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

  }

}


