import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../shared/const/api-url.const.dart';
import '../models/favorite-news.model.dart';

class FavoritesNewsRepository {
  Future<FavoriteNewsM> getFavoritesNewsById({required String id}) async {
    final response = await http.get(
      Uri.parse(FAVORITES_NEWS_URL + id),
    );
    if (response.statusCode == 200) {
      return FavoriteNewsM.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Unexpected error occurred in NewsPack repository!');
    }
  }
}
