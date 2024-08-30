import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shout/src/models/news_model.dart';
// import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '../config/constants.dart';
class NewsApiService {
  final String apiKey = 'pub_4852775f9307ec6aa371cdeda93b54153e4aa';
  final String baseUrl = 'https://newsdata.io/api/1/latest';
  final List<String> _categories = AppConstants.categories;

  Future<String> _getCacheFilePath(String category) async {
    final directory = await getTemporaryDirectory();
    return '${directory.path}/news_cache_$category.json';
  }

  Future<List<dynamic>> fetchCategoryNews() async {
    List<dynamic> categoryNews = [];

    for (String category in _categories) {
      final cacheFilePath = await _getCacheFilePath(category);
      final cacheFile = File(cacheFilePath);


      if (await cacheFile.exists()) {
        final cacheTimestamp = await cacheFile.lastModified();
        if (DateTime.now().difference(cacheTimestamp).inHours < 1) {
          final cachedData = await cacheFile.readAsString();
          final data = json.decode(cachedData);
          categoryNews.add(data['results'][0]);
          continue;
        }
      }

      final response = await http.get(
        Uri.parse('$baseUrl?apikey=$apiKey&q=$category&language=en'),
      );

      if (response.statusCode == 200) {

        final data = json.decode(response.body);
        await cacheFile.writeAsString(response.body);

        categoryNews.add(data['results'][0]);
      } else if (response.statusCode == 404) {
        throw Exception('Not found');
      } else {
        print('Failed to load news for category $category: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load news for category $category');
      }
    }

    return categoryNews;
  }

  Future<List<dynamic>> fetchNews(String query) async {
    final cacheFilePath = await _getCacheFilePath(query);
    final cacheFile = File(cacheFilePath);

    if (await cacheFile.exists()) {
      final cacheTimestamp = await cacheFile.lastModified();
      if (DateTime.now().difference(cacheTimestamp).inHours < 1) {
        final cachedData = await cacheFile.readAsString();
        final data = json.decode(cachedData);
        return data['results'];
      }
    }

    final response = await http.get(
      Uri.parse('$baseUrl?apikey=$apiKey&q=$query&language=en'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Lưu cache
      await cacheFile.writeAsString(response.body);
      return data['results'];
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      print('Failed to load news: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load news');
    }
  }


  Future<Map<String, dynamic>> fetchArticleByUrl(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      print('Failed to load article: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load article');
    }
  }
}
