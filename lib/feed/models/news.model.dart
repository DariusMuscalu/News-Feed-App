// I think theres no need to add toJson method at this point because we don't send anything to the server.
// TODO Leave explanatory comment.
// They can be null because the API might not contain some of them. Do not remove the null safety!
class NewsM {
  final String? title;
  final String? url;
  final String? publishDate;
  final String? author;
  final int? numberOfComments;
  final int? numberOfPoints;

  const NewsM({
    required this.title,
    required this.url,
    required this.publishDate,
    required this.author,
    required this.numberOfComments,
    required this.numberOfPoints,
  });

  factory NewsM.fromJson(Map<String, dynamic> json) => NewsM(
        title: json['title'],
        url: json['url'],
        publishDate: json['created_at'],
        author: json['author'],
        numberOfComments: json['num_comments'],
        numberOfPoints: json['points'],
      );
}
