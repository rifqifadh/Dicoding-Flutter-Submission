import 'dart:async';

import 'package:sqflite/sqflite.dart';

enum WatchlistType { movie, tvSeries }

abstract class WatchlistTableInterface {
  int? id;
  String? title;
  String? overview;
  String? posterPath;
  int? nextEpisode;
  String? nextEpisodeName;
  String? nextEpisodeToAir;
  int? seasonNumber;
  WatchlistType? type;

  WatchlistTableInterface({
    this.id,
    this.title,
    this.overview,
    this.posterPath,
    this.nextEpisode,
    this.nextEpisodeName,
    this.nextEpisodeToAir,
    this.seasonNumber,
    this.type,
  });

  Map<String, dynamic> toJson();
}

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblWatchlist = 'watchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        nextEpisode INTEGER,
        nextEpisodeName TEXT,
        nextEpisodeToAir TEXT,
        seasonNumber INTEGER,
        type TEXT
      );
    ''');
  }

  Future<int> insertWatchlist(WatchlistTableInterface watchlist) async {
    final db = await database;
    return await db!.insert(_tblWatchlist, watchlist.toJson());
  }

  Future<int> removeWatchlist(WatchlistTableInterface watchlist) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [watchlist.id],
    );
  }

  Future<Map<String, dynamic>?> getWatchlistById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlist() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }
}
