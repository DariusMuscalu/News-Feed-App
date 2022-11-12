import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../feed/models/news.model.dart';
import '../../shared/const/api-url.const.dart';

class FavoritesNewsRepository {
  Future<NewsM> getFavoritesNewsById({required String id}) async {
    final response = await http.get(
      Uri.parse(FAVORITES_NEWS_URL + id),
    );
    if (response.statusCode == 200) {
      return NewsM.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Unexpected error occurred in NewsPack repository!');
    }
  }
}
