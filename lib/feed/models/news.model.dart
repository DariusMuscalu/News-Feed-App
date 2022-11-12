import 'package:flutter/material.dart';

// No need for toJson method, we are not sending anything to the server. At least for the moment.
//
// Properties can be null because the API might not contain some of them. Do not remove the null safety!
// TODO Leave explanatory comment.
@immutable
class NewsM {
  final String? title;
  final String? url;
  final String? publishDate;
  final String? author;
  final int? numberOfComments;
  final int? numberOfPoints;
  final String? newsId;

  const NewsM({
    required this.title,
    required this.url,
    required this.publishDate,
    required this.author,
    required this.numberOfComments,
    required this.numberOfPoints,
    required this.newsId,
  });

  factory NewsM.fromJson(Map<String, dynamic> json) =>
      NewsM(
        title: json['title'],
        url: json['url'],
        publishDate: json['created_at'],
        author: json['author'],
        numberOfComments: json['num_comments'],
        numberOfPoints: json['points'],
        newsId: json['objectID'],
      );
}
