import 'package:flutter/material.dart';

// A shared component used to wrap all pages inside the app.
// It prevents overflow of the content inside mobiles, every page should be wrapped with it!
// ignore_for_file: file_names
class PageShell extends StatelessWidget {
  final Widget appBarChild;
  final List<Widget> children;

  const PageShell({
    required this.appBarChild,
    required this.children,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(
        appBarChild: appBarChild,
      ),
      body: _centeredCol(
        children: children,
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  AppBar _appBar({required Widget appBarChild}) => AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        title: appBarChild,
      );

  Widget _centeredCol({required List<Widget> children}) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      );

  // TODO CONST LITERALS AND LOOP THROUGH THEM
  // TODO See how to switch pages from the bottom nav.
  Widget _bottomNavigationBar() => BottomNavigationBar(
        backgroundColor: Colors.red,
        items: const [
          BottomNavigationBarItem(
            label: 'Main Feed',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Favorites',
            icon: Icon(Icons.star),
          ),
          BottomNavigationBarItem(
            label: 'Calendar',
            icon: Icon(Icons.calendar_today),
          ),
        ],
      );
}
