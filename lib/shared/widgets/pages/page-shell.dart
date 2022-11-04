import 'package:flutter/material.dart';

// A shared component used to wrap all pages inside the app.
// It prevents overflow of the content inside mobiles, every page should be wrapped with it!
// TODO See if you should add _centeredCol in the body here too.
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        title: appBarChild,
      ),
      body: _centeredCol(
        children: children,
      ),
    );
  }

  Widget _centeredCol({required List<Widget> children}) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      );
}
