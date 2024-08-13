import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/news_model.dart';


class BookmarkManager {
  List<NewsArticle> _bookmarks = [];

  Future<void> loadBookmarks() async {
    final file = await _localFile;
    if (await file.exists()) {
      final content = await file.readAsString();
      final List<dynamic> jsonData = json.decode(content);
      _bookmarks = jsonData.map((data) => NewsArticle.fromJson(data)).toList();
    }
  }

  Future<void> addBookmark(NewsArticle article) async {
    _bookmarks.add(article);
    await _saveToFile();
  }

  Future<void> removeBookmark(NewsArticle article) async {
    _bookmarks.removeWhere((a) => a.link == article.link);
    await _saveToFile();
  }

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/bookmarks.json');
  }

  Future<void> _saveToFile() async {
    final file = await _localFile;
    final jsonData = _bookmarks.map((article) => article.toJson()).toList();
    await file.writeAsString(json.encode(jsonData));
  }

  List<NewsArticle> get bookmarks => _bookmarks;
}
