import 'package:flutter/material.dart';
import 'package:flutter_app/categories_page.dart';

import 'transactions_page.dart';

class IdIncrement {
  int _i = 0;
  IdIncrement([this._i = 0]);

  int get i {
    _i++;
    return _i - 1;
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  int index = 0;

  final GlobalKey navBarKey = GlobalKey(debugLabel: "Nav Bar");
  final GlobalKey scaffoldKey = GlobalKey(debugLabel: "Scaffold");

  void _newDestination(int id) {
    setState(() {
      index = id;
    });
  }

  NavigationBar navBar(int i) {
    return NavigationBar(
      key: i == index ? navBarKey : null,
      destinations: const [
        NavigationDestination(
            icon: Icon(Icons.data_array), label: "Transactions"),
        NavigationDestination(
            icon: Icon(Icons.bluetooth_searching_rounded), label: "Categories"),
      ],
      onDestinationSelected: _newDestination,
      selectedIndex: index,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: index,
      children: [
        TransactionsPage(
            navBar: navBar(0), scaffoldKey: index == 0 ? scaffoldKey : null),
        CategoriesPage(
            navBar: navBar(1), scaffoldKey: index == 1 ? scaffoldKey : null)
      ],
    );
  }
}
