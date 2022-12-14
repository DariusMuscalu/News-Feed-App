import 'package:flutter/material.dart';
import 'package:news_app/shared/const/template-dimensions.const.dart';
import 'package:news_app/shared/widgets/pages/page-shell.dart';
import 'package:provider/provider.dart';

import '../providers/favorites-news.provider.dart';
import '../widgets/cards/favorite-news-card.dart';

class FavoritesNewsPage extends StatefulWidget {
  const FavoritesNewsPage({Key? key}) : super(key: key);

  @override
  State<FavoritesNewsPage> createState() => _FavoritesNewsPageState();
}

class _FavoritesNewsPageState extends State<FavoritesNewsPage> {
  @override
  void initState() {
    // Gets the favorite news ids from prefs. Because we need to access them from the local memory
    // in order to not reset them after each time we restart the app.
    Provider.of<FavoritesNewsProvider>(context, listen: false)
      ..getFavoritesNewsIdsFromPrefs()
      ..fetchFavoritesNewsById();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => PageShell(
        appBarChild: const Text('Favorites News'),
        children: <Widget>[
          _favoritesNews(),
        ],
      );

  Widget _favoritesNews() => Expanded(
        child: Container(
          color: const Color(0xFF2C2B30),
          child: ListView(
            children: [
              Consumer<FavoritesNewsProvider>(
                builder: (context, favoritesNewsService, child) {
                  return favoritesNewsService.favoriteNewsById == null
                      ? SPINKIT
                      : Column(
                          children: [
                            for (final news
                                in favoritesNewsService.favoriteNewsById!)
                              FavoriteNewsCard(
                                news: news,
                              ),
                          ],
                        );
                },
              ),
            ],
          ),
        ),
      );
}
