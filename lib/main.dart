import 'package:flutter/material.dart';
import 'package:news_app/feed/services/news-pack.service.dart';
import 'package:news_app/router.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  // Removes the '#' from the URL.
  setPathUrlStrategy();

  return runApp(const App());
}

// TODO See if you should move this class from this file.
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => NewsPackService(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        ),
      );
}
