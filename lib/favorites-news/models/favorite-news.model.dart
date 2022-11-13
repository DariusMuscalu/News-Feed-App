import 'package:flutter/material.dart';

// No need for toJson method, we are not sending anything to the server. At least for the moment.
//
// Properties can be null because the API might not contain some of them. Do not remove the null safety!
// TODO Leave explanatory comment why it's different from news model.
@immutable
class FavoriteNewsM {
  final String? title;
  final String? url;
  final String? publishDate;
  final String? author;
  final int? numberOfPoints;
  final int? newsId;

  const FavoriteNewsM({
    required this.title,
    required this.url,
    required this.publishDate,
    required this.author,
    required this.numberOfPoints,
    required this.newsId,
  });

  factory FavoriteNewsM.fromJson(Map<String, dynamic> json) =>
      FavoriteNewsM(
        title: json['title'],
        url: json['url'],
        publishDate: json['created_at'],
        author: json['author'],
        numberOfPoints: json['points'],
        newsId: json['id'],
      );
}
