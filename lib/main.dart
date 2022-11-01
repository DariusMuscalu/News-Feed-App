import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/calendar/pages/calendar.page.dart';
import 'package:news_app/favorites/pages/favorites.page.dart';
import 'package:news_app/router.dart';
import 'package:url_strategy/url_strategy.dart';

import 'feed/pages/feed.page.dart';

// This scenario demonstrates a simple two-page app.
//
// The first route '/' is mapped to Page1Screen, and the second route '/page2'
// is mapped to Page2Screen. To navigate between pages, press the buttons on the
// pages.
//
// The onPress callbacks use context.go() to navigate to another page. This is
// equivalent to entering url to the browser url bar directly.

void main() {
  // Removes the '#' from the URL.
  setPathUrlStrategy();

  return runApp(const App());
}

// TODO See if you should move this class from this file.
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerConfig: router,
      );
}
