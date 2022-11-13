import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/images/svg.dart';
import '../../../shared/utils/feed.utils.dart';
import '../../../shared/widgets/buttons/button.dart';
import '../../models/favorite-news.model.dart';
import '../../providers/favorites-news.provider.dart';

// The card that is responsible for displaying all the data of each news.
// ignore_for_file: file_names
class FavoriteNewsCard extends StatefulWidget {
  final FavoriteNewsM news;

  const FavoriteNewsCard({
    required this.news,
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteNewsCard> createState() => _FavoriteNewsCardState();
}

class _FavoriteNewsCardState extends State<FavoriteNewsCard> {
  final _feedUtils = FeedUtils();

  @override
  Widget build(BuildContext context) {
    return _newsCard(
      news: widget.news,
    );
  }

  // TODO Remove the need for literals in sizes of this method.
  Widget _newsCard({required FavoriteNewsM? news}) => Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(10),
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
                _numberOfPoints(
                  points: news?.numberOfPoints ?? 0,
                ),
                _publishDate(
                  date: news?.publishDate ?? '',
                ),
                _addToFavoritesBtn(
                  newsId: news?.newsId! ?? 0,
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

  // TODO Add own icon and make shared components with the comments method.
  Widget _numberOfPoints({required int points}) => Row(
        children: [
          Text(
            '$points',
            style: const TextStyle(
              color: Colors.brown,
            ),
          ),
          Svg(
            iconUrl: 'lib/assets/comments/comments-icon.svg',
          ),
        ],
      );

  Widget _publishDate({required String date}) => Text(date);

  Widget _addToFavoritesBtn({required int newsId}) {
    return Consumer<FavoritesNewsProvider>(
      builder: (context, favoriteNewsService, child) {
        return SizedBox(
          width: 100,
          child: Button(
            iconUrl: 'lib/assets/star-icon.svg',
            iconWidth: 20,
            bgrColor: favoriteNewsService.favoriteNewsIds.contains(
              newsId.toString(),
            )
                ? Colors.blue
                : Colors.redAccent,
            hoverColor: Colors.grey,
            hoverBgrColor: Colors.green,
            onTap: () {
              Provider.of<FavoritesNewsProvider>(context, listen: false)
                ..removeNewsFromFavorites(
                  newsId: newsId.toString(),
                )
                ..removeFavoriteNewsIdFromPrefs(
                  newsId: newsId.toString(),
                )
                // In order to update the layout.
                ..updateFavoriteNewsById(
                  newsId: newsId.toString(),
                );
            },
          ),
        );
      },
    );
  }
}
