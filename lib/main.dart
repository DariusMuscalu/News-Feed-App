import 'package:flutter/material.dart';
import 'package:news_app/feed/providers/news-pack.provider.dart';
import 'package:news_app/shared/routing/router.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'favorites-news/providers/favorites-news.provider.dart';


void main() {
  // Removes the '#' from the URL.
  setPathUrlStrategy();

  return runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => NewsPackProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FavoritesNewsProvider(),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        ),
      );
}
