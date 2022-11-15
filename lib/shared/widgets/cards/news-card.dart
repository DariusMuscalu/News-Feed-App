import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../favorites-news/providers/favorites-news.provider.dart';
import '../../../feed/models/news.model.dart';
import '../../images/svg.dart';
import '../../utils/feed.utils.dart';

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

  @override
  Widget build(BuildContext context) {
    return _newsCard(
      child: _col(
        children: [
          _title(
            title: widget.news.title ?? '',
          ),
          _row(
            children: [
              _author(
                author: widget.news.author ?? '',
              ),
              _publishDate(
                date: widget.news.publishDate ?? '',
              ),
            ],
          ),
          _row(
            padding: const EdgeInsets.only(top: 15),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _row(
                children: [
                  _numberOfPoints(
                    points: widget.news.numberOfPoints ?? 0,
                  ),
                  _numberOfCommentsRow(
                    commentsNum: widget.news.numberOfComments ?? 0,
                  ),
                ],
              ),
              _addToFavoritesBtn(
                newsId: widget.news.newsId ?? '',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // TODO Remove the need for literals in sizes of this method.
  Widget _newsCard({required Widget child}) => Material(
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
            child: child,
          ),
          onTap: () => _feedUtils.goToUrl(
            url: widget.news.url ?? '',
          ),
        ),
      );

  Widget _col({required List<Widget> children}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      );

  Widget _row({
    required List<Widget> children,
    MainAxisAlignment? mainAxisAlignment,
    EdgeInsets? padding,
  }) =>
      Container(
        padding: padding ?? EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          children: children,
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

  Widget _numberOfCommentsRow({required int commentsNum}) => Row(
        children: [
          _text(
            commentsNum,
          ),
          _commentsIcon(),
        ],
      );

  Widget _text(int commentsNum) => Text(
        '$commentsNum',
        style: const TextStyle(
          color: Color(0xFF9b9b9b),
        ),
      );

  Widget _commentsIcon() => Container(
        padding: const EdgeInsets.only(left: 5),
        child: Svg(
          height: 30,
          color: const Color(0xFF9b9b9b),
          iconUrl: 'lib/assets/comments/comments-icon.svg',
        ),
      );

  // TODO Add own icon and make shared components with the comments method.
  Widget _numberOfPoints({required int points}) => Row(
        children: [
          _text(
            points,
          ),
          _pointsIcon(),
        ],
      );

  Widget _pointsIcon() => Svg(
        height: 40,
        color: const Color(0xFF9b9b9b),
        iconUrl: 'lib/assets/cards/arrow-icon.svg',
      );

  // TODO Write the logic if it's the same date as today, to only show the hour.
  Widget _publishDate({required String date}) => Text(
        DateTime.parse(date).toString(),
        style: const TextStyle(
          color: Color(0xFF9b9b9b),
        ),
      );

  Widget _addToFavoritesBtn({required String newsId}) =>
      Consumer<FavoritesNewsProvider>(
        builder: (context, favoriteNewsService, child) {
          // TODO Add on hover color
          return InkWell(
            // TODO Add tappable container area in order to easily press on mobile.
            child: Svg(
              height: 42,
              color: favoriteNewsService.favoriteNewsIds.contains(newsId)
                  ? const Color(0xFFe6a338)
                  : const Color(0xFF9b9b9b),
              iconUrl: 'lib/assets/star-icon.svg',
            ),
            onTap: () {
              bool isNotFavorite =
                  !favoriteNewsService.favoriteNewsIds.contains(newsId);

              if (isNotFavorite) {
                Provider.of<FavoritesNewsProvider>(context, listen: false)
                  ..addNewsToFavorites(
                    newsId: newsId,
                  )
                  ..addFavoritesNewsIdsToPrefs();
              } else {
                Provider.of<FavoritesNewsProvider>(context, listen: false)
                  ..removeNewsFromFavorites(
                    newsId: newsId,
                  )
                  ..removeFavoriteNewsIdFromPrefs(
                    newsId: newsId,
                  );
              }
            },
          );
        },
      );
}
