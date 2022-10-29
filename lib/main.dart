import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/calendar/calendar.page.dart';
import 'package:news_app/favorites/pages/favorites.page.dart';
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

  return runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  static const String _title = 'GoRouter Example: Declarative Routes';

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerConfig: _router,
        title: _title,
      );

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (
          BuildContext context,
          GoRouterState state,
        ) =>
            const FeedPage(),
        routes: <GoRoute>[
          GoRoute(
            path: 'favorites',
            builder: (
              BuildContext context,
              GoRouterState state,
            ) =>
                const FavoritesPage(),
          ),
          GoRoute(
            path: 'calendar',
            builder: (
              BuildContext context,
              GoRouterState state,
            ) =>
                const CalendarPage(),
          ),
        ],
      ),
    ],
  );
}
