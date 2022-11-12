import 'package:flutter/material.dart';
import 'package:news_app/feed/services/feed.utils.dart';
import 'package:provider/provider.dart';

import '../../../feed/models/news.model.dart';
import '../../../feed/state/feed.state.dart';
import '../../images/svg.dart';
import '../buttons/button.dart';

// The card that is responsible for displaying all the data of each news.
// ignore_for_file: file_names
class NewsCard extends StatefulWidget {
  final NewsM news;

  const NewsCard({
    required this.news,
    Key? key,
  }) : super(key: key);

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  final _feedUtils = FeedUtils();
  final _feedState = FeedState();

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
            margin: const EdgeInsets.all(10),
            width: 400,
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.yellow,
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
                _author(
                  author: news?.author ?? '',
                ),
                _numberOfComments(
                  commentsNum: news?.numberOfComments ?? 0,
                ),
                _numberOfPoints(
                  points: news?.numberOfPoints ?? 0,
                ),
                _publishDate(
                  date: news?.publishDate ?? '',
                ),
                _addToFavoritesBtn(
                  newsId: news?.newsId ?? '',
                ),
              ],
            ),
          ),
          onTap: () => _feedUtils.goToUrl(
            url: news?.url ?? '',
          ),
        ),
      );

  Widget _title({required String title}) => Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
        ),
      );

  Widget _author({required String author}) => Text(
        author,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      );

  // TODO Add modify name of the method and break it into multiple ones??
  Widget _numberOfComments({required int commentsNum}) => Row(
        children: [
          Text(
            '$commentsNum',
            style: const TextStyle(
              color: Colors.brown,
            ),
          ),
          const Svg(
            height: 30,
            color: Colors.black,
            iconUrl: 'lib/assets/comments/comments-icon.svg',
          ),
        ],
      );

  // TODO Add own icon and make shared components with the comments method.
  Widget _numberOfPoints({required int points}) => Row(
        children: [
          Text(
            '$points',
            style: const TextStyle(
              color: Colors.brown,
            ),
          ),
          const Svg(
            iconUrl: 'lib/assets/comments/comments-icon.svg',
          ),
        ],
      );

  Widget _publishDate({required String date}) => Text(date);

  // TODO See if you should add alias to the bg color bool.
  Widget _addToFavoritesBtn({required String newsId}) => Button(
        bgrColor: _feedState.favoriteNewsIds.contains(newsId)
            ? Colors.redAccent
            : Colors.green,
        hoverColor: Colors.grey,
        hoverBgrColor: Colors.green,
        name: 'Add to favorites',
        onTap: () {
          Provider.of<FeedState>(context, listen: false)
            ..addNewsToFavorites(
              newsId: newsId,
            )
            ..addFavoritesNewsToPrefs();
          // Used to trigger the building of the widget in order to change the color
          // Find a proper way to do it with the provider.
          setState(() {});
        },
      );
}