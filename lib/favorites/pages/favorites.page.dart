import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Favorites Page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
          ),
        ),
      );
}
