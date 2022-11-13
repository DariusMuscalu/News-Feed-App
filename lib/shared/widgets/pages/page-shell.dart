import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// A shared component used to wrap all pages inside the app.
// It prevents overflow of the content inside mobiles, every page should be wrapped with it!
// ignore_for_file: file_names

// Used to set the selected page in the bottom nav bar.
// The reason it's outside is because when triggering the set state method, it will get reset if it's inside the widget.
// TODO See if you should move it in a service.
int _currentPageIndex = 0;

class PageShell extends StatefulWidget {
  final Widget appBarChild;
  final List<Widget> children;

  const PageShell({
    required this.appBarChild,
    required this.children,
    Key? key,
  }) : super(key: key);

  @override
  State<PageShell> createState() => _PageShellState();
}

class _PageShellState extends State<PageShell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(
        appBarChild: widget.appBarChild,
      ),
      body: _centeredCol(
        children: widget.children,
      ),
      bottomNavigationBar: _bottomNavigationBar(
        context,
      ),
    );
  }

  PreferredSize _appBar({required Widget appBarChild}) => PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF2C2B30),
          title: appBarChild,
        ),
      );

  Widget _centeredCol({required List<Widget> children}) => Container(
        color: const Color(0xFF2C2B30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...children,
              _divider(),
            ],
          ),
        ),
      );

  // TODO CONST LITERALS AND LOOP THROUGH THEM for btns
  Widget _bottomNavigationBar(BuildContext context) => BottomNavigationBar(
        backgroundColor: const Color(0xFF2C2B30),
        currentIndex: _currentPageIndex,
        onTap: (pageIndex) {
          switch (pageIndex) {
            case (0):
              {
                context.go('/');
                break;
              }
            case (1):
              {
                context.go('/favorites');
                break;
              }
            case (2):
              {
                context.go('/calendar');
                break;
              }
            default:
              {
                context.go('/');
              }
          }

          setState(() {
            _currentPageIndex = pageIndex;
          });
        },
        unselectedItemColor: Colors.white70,
        selectedItemColor: Colors.white,
        iconSize: 24,
        items: const [
          BottomNavigationBarItem(
            tooltip: '',
            backgroundColor: Colors.white,
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            tooltip: '',
            backgroundColor: Colors.white,
            label: 'Favorites',
            icon: Icon(Icons.star),
          ),
          BottomNavigationBarItem(
            tooltip: '',
            label: 'Calendar',
            icon: Icon(Icons.calendar_today),
          ),
        ],
      );

  Widget _divider() => const Divider(
        height: 2,
        thickness: 0.7,
        color: Colors.grey,
      );
}
