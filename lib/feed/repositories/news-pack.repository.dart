import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/feed/models/news-pack.model.dart';

class NewsPackRepository {
  // TODO Make as a const and move it to a different file.
  static const String url = 'https://hn.algolia.com/api/v1/search?tags=front_page';

  Future<NewsPackM> fetchNewsM() async {
    final response = await http.get(url as Uri);
    if (response.statusCode == 200) {
      print('OKKKKKK ----------------------------------------');
      return NewsPackM.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Unexpected error occurred in NewsM repository!');
    }
  }
}
