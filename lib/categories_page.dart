import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage(
      {super.key, required this.navBar, required this.scaffoldKey});

  final NavigationBar navBar;
  final Key? scaffoldKey;

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: widget.scaffoldKey,
        floatingActionButton: FloatingActionButton(onPressed: null),
        bottomNavigationBar: widget.navBar,
        body: const Center(
          child: Card(
            child: Text("Hi there"),
          ),
        ));
  }
}
