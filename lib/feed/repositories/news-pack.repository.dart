import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/feed/models/news-pack.model.dart';

import '../../shared/const/api-url.const.dart';

class NewsPackRepository {
  Future<NewsPackM> fetchNewsM() async {
    final response = await http.get(
      Uri.parse(FRONT_PAGE_URL),
    );
    if (response.statusCode == 200) {
      return NewsPackM.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Unexpected error occurred in NewsPack repository!');
    }
  }
}
