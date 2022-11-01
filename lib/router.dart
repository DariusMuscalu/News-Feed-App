// Routes
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'calendar/pages/calendar.page.dart';
import 'favorites/pages/favorites.page.dart';
import 'feed/pages/feed.page.dart';

final GoRouter router = GoRouter(
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