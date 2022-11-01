class NewsM {
  final String title;
  final String publishDate;
  final String author;
  final int numberOfComments;
  final int numberOfPoints;

  const NewsM({
    required this.title,
    required this.publishDate,
    required this.author,
    required this.numberOfComments,
    required this.numberOfPoints,
  });

  // TODO Add toJson and fromJson methods
  factory NewsM.fromJson(Map<String, dynamic> json) => NewsM(
      author: json['author'],
      numberOfComments: json['num_comments'],
      numberOfPoints: json['points'],
      publishDate: json['created_at'],
      title: json['title'],
    );
}
