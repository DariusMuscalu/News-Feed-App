import 'package:flutter/material.dart';

import '../../../feed/models/news.model.dart';
import '../../images/svg.dart';
import '../../utils/feed.utils.dart';

// The card that is responsible for displaying all the data of each news.
// ignore_for_file: file_names
class NewsCard extends StatefulWidget {
  final NewsM news;
  final Widget button;

  const NewsCard({
    required this.news,
    required this.button,
    Key? key,
  }) : super(key: key);

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  final _feedUtils = FeedUtils();

  @override
  Widget build(BuildContext context) {
    return _newsCard(
      news: widget.news,
    );
  }

  // TODO Remove the need for literals in sizes of this method.
  Widget _newsCard({required NewsM? news}) => Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(
              vertical: 7,
              horizontal: 14,
            ),
            decoration: const BoxDecoration(
              color: Colors.yellow,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.repeated,
                colors: [
                  Color(0xFF4A3B35),
                  Color(0xFF383836),
                ],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title(
                  title: news?.title ?? '',
                ),
                Row(
                  children: [
                    _author(
                      author: news?.author ?? '',
                    ),
                    _publishDate(
                      date: news?.publishDate ?? '',
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _numberOfPoints(
                            points: news?.numberOfPoints ?? 0,
                          ),
                          _numberOfComments(
                            commentsNum: news?.numberOfComments ?? 0,
                          ),
                        ],
                      ),
                      widget.button,
                    ],
                  ),
                ),
              ],
            ),
          ),
          onTap: () => _feedUtils.goToUrl(
            url: news?.url ?? '',
          ),
        ),
      );

  Widget _title({required String title}) => Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          title,
          style: const TextStyle(
            color: Color(0xFFcccccc),
            fontWeight: FontWeight.w700,
          ),
        ),
      );

  Widget _author({required String author}) => Text(
        'By $author at ',
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.w500,
        ),
      );

  // TODO Modify name of the method and break it into multiple ones??
  Widget _numberOfComments({required int commentsNum}) => Row(
        children: [
          Text(
            '$commentsNum',
            style: const TextStyle(
              color: Color(0xFF9b9b9b),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: Svg(
              height: 30,
              color: const Color(0xFF9b9b9b),
              iconUrl: 'lib/assets/comments/comments-icon.svg',
            ),
          ),
        ],
      );

  // TODO Add own icon and make shared components with the comments method.
  Widget _numberOfPoints({required int points}) => Row(
        children: [
          Text(
            '$points',
            style: const TextStyle(
              color: Color(0xFF9b9b9b),
            ),
          ),
          Svg(
            height: 40,
            color: const Color(0xFF9b9b9b),
            iconUrl: 'lib/assets/cards/arrow-icon.svg',
          ),
        ],
      );

  // TODO Write the logic if it's the same date as today, to only show the hour.
  Widget _publishDate({required String date}) => Text(
        DateTime.parse(date).toString(),
        style: const TextStyle(
          color: Color(0xFF9b9b9b),
        ),
      );
}
