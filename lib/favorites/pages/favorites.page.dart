import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/favorites/services/favorites-news.service.dart';
import 'package:news_app/feed/state/feed.state.dart';
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
  final _feedState = FeedState();
  final _favoritesNewsService = FavoritesNewsService();

  @override
  void initState() {
    _feedState.setFavoritesNewsToPrefs();
    getFavoriteNewsById();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => PageShell(
        appBarChild: const Text('Favorites Page'),
        children: <Widget>[
          _favoritesNews(),
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('Go back to feed page'),
          ),
          ElevatedButton(
            onPressed: () => context.go('/calendar'),
            child: const Text('Go back to calendar page'),
          ),
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
                    return _favoritesNewsService.loading
                        ? SPINKIT
                        : NewsCard(
                            news: _favoritesNewsService.favoriteNews,
                          );
                  },
                ),
                Consumer<FeedState>(
                  builder: (context, feedState, child) {
                    return Text(feedState.favoriteNewsIds.toString());
                  },
                ),
              ],
            ),
          ),
        ],
      );

  void getFavoriteNewsById() {
    _favoritesNewsService.getFavoritesNewsById(
      newsId: _feedState.favoriteNewsIds[0],
    );
  }
}
