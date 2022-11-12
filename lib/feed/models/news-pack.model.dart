import 'package:news_app/feed/models/news.model.dart';

// No need for toJson method, we are not sending anything to the server. At least for the moment.
//
// The API that we are accessing is a big object which contains a list of the news that we need.
// That's why we are using the NewsPackM to store the list of news.
// NewsPackM is holding all the news from the API.
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
