import 'package:news_app/feed/models/news.model.dart';

// No need for toJson method, we are not sending anything to the server.
class NewsPackM {
  final List<NewsM> news;

  NewsPackM({required this.news});

  factory NewsPackM.fromJson(Map<String, dynamic> json) => NewsPackM(
        news: json['hits'] != null
            ? (json['hits'] as List)
                .map((news) => NewsM.fromJson(news))
                .toList()
            : [],
      );
}
