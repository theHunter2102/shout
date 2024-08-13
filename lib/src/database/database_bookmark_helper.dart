import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/news_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'bookmarks.db');

    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE bookmarks(id INTEGER PRIMARY KEY, email TEXT, title TEXT, description TEXT, urlToImage TEXT, category TEXT, creator TEXT, link TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> addBookmark(String email, NewsArticle article) async {
    final db = await database;

    await db.insert(
      'bookmarks',
      {
        'email': email,
        ...article.toJson(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<NewsArticle>> getBookmarksByEmail(String email) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'bookmarks',
      where: 'email = ?',
      whereArgs: [email],
    );

    return List.generate(maps.length, (i) {
      return NewsArticle.fromJson(maps[i]);
    });
  }
}
