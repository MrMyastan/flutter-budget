import 'package:flutter/material.dart';

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

  final List<(Widget, NavigationDestination)> pages = const [
    (
      TransactionsPage(),
      NavigationDestination(icon: Icon(Icons.data_array), label: "Transactions")
    ),
    (
      TransactionsPage(),
      NavigationDestination(
          icon: Icon(Icons.bluetooth_searching_rounded), label: "Categories")
    )
  ];

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    print((widget.pages[1].$1));
    print(index);
    return Scaffold(
      body: widget.pages[index].$1,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) {
          setState(() {
            index = value;
          });
        },
        destinations: widget.pages.map((e) => e.$2).toList(),
      ),
    );
  }
}
