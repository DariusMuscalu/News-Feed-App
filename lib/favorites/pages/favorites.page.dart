import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/shared/widgets/pages/page-shell.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => PageShell(
        appBarChild: const Text('Favorites Page'),
        children: <Widget>[
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
}
