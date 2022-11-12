import 'package:flutter/material.dart';
import 'package:news_app/favorites/services/favorites-news.service.dart';
import 'package:news_app/shared/const/template-dimensions.const.dart';
import 'package:news_app/shared/widgets/cards/news-card.dart';
import 'package:news_app/shared/widgets/pages/page-shell.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    // TODO Review comment.
    // Gets the favorite news from prefs. Because we need to access them from the local memory
    // in order to not be reset after each time we restart the app.
    Provider.of<FavoritesNewsService>(context, listen: false)
      ..setFavoritesNewsIdsToPrefs()
      ..getFavoritesNewsById();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => PageShell(
        appBarChild: const Text('Favorites Page'),
        children: <Widget>[
          _favoritesNews(),
        ],
      );

  Widget _favoritesNews() => Column(
        children: [
          Container(
            width: 600,
            height: 400,
            color: Colors.blue,
            child: Column(
              children: [
                Consumer<FavoritesNewsService>(
                  builder: (context, favoritesNewsService, child) {
                    return favoritesNewsService.favoriteNewsById == null
                        ? SPINKIT
                        : NewsCard(
                            news: favoritesNewsService.favoriteNewsById!,
                          );
                  },
                ),
                Consumer<FavoritesNewsService>(
                  builder: (context, feedState, child) {
                    return Text(feedState.favoriteNewsIds.toString());
                  },
                ),
              ],
            ),
          ),
        ],
      );
}
