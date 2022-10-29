import 'package:http/http.dart' as http;

class NewsRepository {
  final String url = 'https://hn.algolia.com/api/v1/search?tags=front_page';
}