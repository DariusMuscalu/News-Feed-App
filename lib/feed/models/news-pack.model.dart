import 'package:news_app/feed/models/news.model.dart';

class NewsPackM {
  final List<NewsM> news;

  NewsPackM({required this.news});

  // TODO Add toJson and fromJson methods
  factory NewsPackM.fromJson(Map<String, dynamic> json) => NewsPackM(
        news: json['hits'] != null
            ? (json['hits'] as List)
                .map((news) => NewsM.fromJson(news))
                .toList()
            : [],
      );
}
